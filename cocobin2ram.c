/*****************************************************************************
 * cocobin2ram - Tandy CoCo Disk BASIC binary convertor                      *
 *****************************************************************************
 * Copyright 2021-2024 Marco Spedaletti (asimov@mclink.it)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *----------------------------------------------------------------------------
 * Concesso in licenza secondo i termini della Licenza Apache, versione 2.0
 * (la "Licenza"); è proibito usare questo file se non in conformità alla
 * Licenza. Una copia della Licenza è disponibile all'indirizzo:
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Se non richiesto dalla legislazione vigente o concordato per iscritto,
 * il software distribuito nei termini della Licenza è distribuito
 * "COSÌ COM'È", SENZA GARANZIE O CONDIZIONI DI ALCUN TIPO, esplicite o
 * implicite. Consultare la Licenza per il testo specifico che regola le
 * autorizzazioni e le limitazioni previste dalla medesima.
 ****************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int usage( int _argc, char *_argv[] ) {

    printf( "%s v1.0\n", _argv[0] );
    printf( "\n" );
    printf( "Usage:\n");
    printf( "   %s <file bin> <file ram>\n\n", _argv[0]);

    return 0;

}

int main( int _argc, char *_argv[] ) {

    if ( _argc < 3 ) {
        usage( _argc, _argv );
        return 0;
    }

    char * fileInputName = _argv[1];
    char * fileOutputName = _argv[2];

    FILE * fin = fopen( fileInputName, "rb" );
    FILE * fout = fopen( fileOutputName, "wb" );

    while( !feof( fin ) ) {

        int header = (int)fgetc(fin);
        int size = (int)fgetc(fin) + (((int)fgetc(fin))<<8);
        int address = (int)fgetc(fin) + (((int)fgetc(fin))<<8);

        if ( header == 0 ) {
            char * content = malloc( size );
            memset( content, 0, size );
            if ( ! fread( content, 1, size, fin ) ) {
                perror( "Unable to read segment");
            }
            fwrite( content, 1, size, fout );
            free( content );
        }

    }

    fclose( fout );
    fclose( fin );

    return 0;

}
