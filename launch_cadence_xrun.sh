#!/bin/bash
source /umbc/software/scripts/cadence_2021.bashrc
#export PATH=/umbc/software/cadence/installs/INCISIVE152/tools.lnx86/bin/64bit/:$PATH
export PATH=/umbc/software/cadence/installs/XCELIUMMAIN22/tools.lnx86/bin/:$PATH
export PATH=/umbc/software/cadence/installs/XCELIUMMAIN22/tools.lnx86/bin/64bit:$PATH
export UVM_HOME=/umbc/software/cadence/installs/XCELIUMMAIN22/tools.lnx86/methodology/UVM/CDNS-IEEE-ML
#export PATH=/umbc/software/cadence/installs/XCELIUM2003/tools.lnx86/bin/64bit:$PATH
#export PATH=/umbc/software/cadence/installs/XCELIUM2003/tools.lnx86/bin/64bit:$PATH

xrun $@





