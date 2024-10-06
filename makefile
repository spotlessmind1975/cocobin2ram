#/*****************************************************************************
#/* cocobin2ram - Tandy CoCo Disk BASIC binary convertor                      *
# *****************************************************************************
# * Copyright 2020-2024 Marco Spedaletti (asimov@mclink.it)
# *
# * Licensed under the Apache License, Version 2.0 (the "License");
# * you may not use this file except in compliance with the License.
# * You may obtain a copy of the License at
# *
# * http://www.apache.org/licenses/LICENSE-2.0
# *
# * Unless required by applicable law or agreed to in writing, software
# * distributed under the License is distributed on an "AS IS" BASIS,
# * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# * See the License for the specific language governing permissions and
# * limitations under the License.
# *----------------------------------------------------------------------------
# * Concesso in licenza secondo i termini della Licenza Apache, versione 2.0
# * (la "Licenza"); è proibito usare questo file se non in conformità alla
# * Licenza. Una copia della Licenza è disponibile all'indirizzo:
# *
# * http://www.apache.org/licenses/LICENSE-2.0
# *
# * Se non richiesto dalla legislazione vigente o concordato per iscritto,
# * il software distribuito nei termini della Licenza è distribuito
# * "COSÌ COM'È", SENZA GARANZIE O CONDIZIONI DI ALCUN TIPO, esplicite o
# * implicite. Consultare la Licenza per il testo specifico che regola le
# * autorizzazioni e le limitazioni previste dalla medesima.
# ****************************************************************************/

#-----------------------------------------------------------------------------
#--- MAKEFILE's ENVIRONMENT
#-----------------------------------------------------------------------------

CFLAGS=-O3 -fomit-frame-pointer
LFLAGS=
LIBS=

.PHONY: clean all

all: cocobin2ram

#-----------------------------------------------------------------------------
#--- MAKEFILE's ENVIRONMENT
#-----------------------------------------------------------------------------

# Check if the compilation is for a BETA version or not.
# In this case, the ".beta" suffix will be added to the executable.

ifeq ($(OS),Windows_NT)
  EXESUFFIX = .exe
  CFLAGS += -D_WIN32 -static
  LFLAGS += -static
else
  EXESUFFIX = 
endif

#-----------------------------------------------------------------------------
#--- MAKEFILE's VARIABLES
#-----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# COMPILATION RULES
# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------

SOURCES := $(wildcard *.c)

OBJS = $(SOURCES:%.c=%.o)

cocobin2ram: $(OBJS)
	@$(CC) $(LFLAGS) $^ -o cocobin2ram$(EXESUFFIX) $(LIBS)
	
%.o: %.c
	@$(CC) $(CFLAGS) -c $< -o $@

clean:
	@rm -r *.o
	@rm -r *${EXESUFFIX}

