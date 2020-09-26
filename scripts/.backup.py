#! /usr/bin/python

# crontab rule ('sudo pacman -Syu moreutils' for ts)
# 1 * * * * * ~/.backup.py | ts >> ~/.backup.log

DIRS = []
DST_DIR = ''
REMOTE_DIR = ''
ARCHIVE_PASS = ''
DAYS = 14

import os
from os.path import isfile, join, expanduser

class Backup:
    def required(self):
        pass

    def do(self):
        pass
    
    def rotate(self):
        pass
    
    def obsoleteFiles(self, files):
        return list(reversed(files))[DAYS:]

class LocalBackup(Backup):
    def __init__(self):
        from datetime import date
        self.backupFilePath = join(DST_DIR, date.today().strftime("%y.%m.%d.7z"))

    def required(self):
        return not isfile(expanduser(self.backupFilePath))

    def do(self):
        os.system('7za a -bsp0 -bso0 -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on -mhe=on -p"%s" %s %s' 
                % (ARCHIVE_PASS, self.backupFilePath, ' '.join(DIRS)))

    def rotate(self):
        dstDir = expanduser(DST_DIR)
        files = [f for f in sorted(os.listdir(dstDir)) if isfile(join(dstDir, f))]

        for name in self.obsoleteFiles(files):
            filePath = join(dstDir, name)
            print('Rotate backup file "%s"' % filePath)
            os.remove(filePath)

class GDriveBackup(Backup):
    def __init__(self):
        self.lastBackupFile = expanduser('~/.last-gdrive-backup')

    def required(self):
        try:
            mtime = os.path.getmtime(self.lastBackupFile)

            from datetime import datetime
            dt = datetime.fromtimestamp(mtime)

            fmt = '%y.%m.%d'
            from datetime import date
            return dt.strftime(fmt) != date.today().strftime(fmt)
        except FileNotFoundError:
            return True

    def do(self):
        if os.system('rclone copy -u %s %s' % (DST_DIR, REMOTE_DIR)):
            raise 'rclone copy - failed'
        os.system('touch %s' % self.lastBackupFile)

    def rotate(self):
        import subprocess
        jsonFiles = subprocess.check_output("rclone lsjson %s" % REMOTE_DIR, shell=True)

        import json
        files = json.loads(jsonFiles);

        for fileInfo in self.obsoleteFiles(files):
            filePath = REMOTE_DIR + '/' + fileInfo['Name']
            print('Rotate remote backup file "%s"' % filePath)
            os.system('rclone delete -v %s ' % filePath)

def parseArgs():
    global DIRS
    global DST_DIR
    global REMOTE_DIR
    global ARCHIVE_PASS
    global DAYS

    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('dirs', metavar='Dir', nargs='+', help='Directories to backup')
    parser.add_argument("-o", "--output", help="Destination directory", required=True)
    parser.add_argument("-r", "--remote", help="Remote directory", required=True)
    parser.add_argument("-p", "--password", help="Archive password", required=True)
    parser.add_argument("-d", "--days", help="Days", type=int, default=DAYS)
    args = parser.parse_args()

    DIRS = args.dirs
    DST_DIR = args.output
    REMOTE_DIR = args.remote
    ARCHIVE_PASS = args.password
    DAYS = args.days

if __name__ == '__main__':
    parseArgs()

    if not ARCHIVE_PASS:
        print('Set password in this script!')
        exit(1)

    for backupType in [LocalBackup, GDriveBackup]:
        backup = backupType()

        if not backup.required():
            continue

        backup.do()
        backup.rotate()

        print('%s done' % backupType.__name__)
