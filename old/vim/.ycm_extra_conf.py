def FlagsForFile( filename, **kwargs ):
    return {
        'flags': [ 
            '-x', 
            'c++', 
            '-Wall', 
            '-Wextra', 
            '-I./path_to_include',
            ]
    }
