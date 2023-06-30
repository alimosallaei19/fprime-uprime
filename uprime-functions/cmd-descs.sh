#!/bin/bash

now=`date`
now=${now// /_}

mkdir -p cmds-${now}
currDirectory=`basename "${PWD}"`

# write to directory/README.md
echo "# ${currDirectory}: Commands" > cmds-${now}/README.md
echo "> Timestamp: ${now}" >> cmds-${now}/README.md
echo "" >> cmds-${now}/README.md
echo "The following is a directory of components and their associated commands:" >> cmds-${now}/README.md

allArgs=("$@")

for i in "${allArgs[@]}"; do
    if [ -d "${i}" ]; then
        echo "=== Going into ${i}... ==="
        untouchableFileName=${i}
        cd ${i}

        # iterate through all folders in the current directory
    for d in */ ; do
        [ -L "${d%/}" ] && continue
        echo "> Going into ${d}..."

        # see if a .cpp file exists in the directory
        if ls ${d}/*.cpp 1> /dev/null 2>&1; then
            # open that file
            for file in ${d}*.cpp; do
                # iterate through lines in file
                cmdInFile=0
                trackingCommand=-1

                cmdNames=()
                cmdDescs=()
                cmdExamplePayloads=()

                while IFS= read -r line; do
                    # check if line starts with "// -- CMD"
                    # remove all leading or trailing whitespace or tabs
                    line=`echo ${line} | sed -e 's/^[[:space:]]*//'`

                    if [[ "${line}" = "// -- CMD" ]]; then
                        trackingCommand=0
                    elif [[ ${trackingCommand} -eq 0 ]]; then
                        #remove "// " from line
                        line=`echo ${line} | cut -c4-`
                        cmdNames+=("${line}")
                        trackingCommand=1
                        continue
                    elif [[ ${trackingCommand} -eq 1 ]]; then
                        line=`echo ${line} | cut -c4-`
                        cmdDescs+=("${line}")
                        trackingCommand=2
                    elif [[ ${trackingCommand} -eq 2 ]]; then
                        line=`echo ${line} | cut -c4-`
                        cmdExamplePayloads+=("${line}")
                        trackingCommand=-1
                        cmdInFile=$((cmdInFile+1))
                    fi
                done < "$file"

                if [[ ${cmdInFile} > 0 ]]; then
                    echo ">> Found ${cmdInFile} commands in ${file}."
                    
                    d=${d%/}
                    i=${i%/}
                    untouchableFileName=${untouchableFileName%/}
                    mkdir -p ../cmds-${now}/${untouchableFileName}
                    
                    echo "# ${untouchableFileName}::${d}" > ../cmds-${now}/${untouchableFileName}/${d}.md
                    fileToAdd=../cmds-${now}/${untouchableFileName}/${d}.md
                    echo "- [${untouchableFileName}::${d}](./cmds-${now}/${untouchableFileName}/${d}.md)" >> ../cmds-${now}/README.md
                    for (( i=0; i<${#cmdNames[@]}; i++ )); do
                        echo "" >> ${fileToAdd}
                        echo "## ${cmdNames[$i]}" >> ${fileToAdd}
                        echo "${cmdDescs[$i]}" >> ${fileToAdd}
                        echo "" >> ${fileToAdd}
                        echo "### Example Payload" >> ${fileToAdd}
                        echo "\`\`\`" >> ${fileToAdd}
                        echo ${cmdExamplePayloads[$i]} >> ${fileToAdd}
                        echo "\`\`\`" >> ${fileToAdd}
                        echo "" >> ${fileToAdd}
                        echo "---" >> ${fileToAdd}
                    done
                    else
                        echo ">> Error: No commands found in ${file}."
                fi
            done
        else
            echo ">> Error: No .cpp files found in ${d}."
        fi
    done
    else
        echo "Directory doesn't exist."
    fi
done