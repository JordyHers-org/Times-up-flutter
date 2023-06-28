#!/bin/bash

PRE_COMMIT_PATH=".git/hooks/pre-commit"

# Create pre-commit file in .git/hooks directory
echo '#!/bin/bash' > $PRE_COMMIT_PATH
echo '' >> $PRE_COMMIT_PATH

# Add the desired code to the pre-commit file
echo 'TICKET=$(git rev-parse --abbrev-ref HEAD | grep -Eo "^(\\w+/)?(\\w+[-_])?[0-9]+" | grep -Eo "(\\w+[-])?[0-9]+" | tr "[:upper:]" "[:lower:]")' >> $PRE_COMMIT_PATH
echo 'MESSAGE=$(git log -1 --pretty=%B | tr "[:upper:]" "[:lower:]")' >> $PRE_COMMIT_PATH
echo '' >> $PRE_COMMIT_PATH
echo 'echo "Your commit message : $MESSAGE"' >> $PRE_COMMIT_PATH
echo 'echo "The ticket number : $TICKET"' >> $PRE_COMMIT_PATH
echo '' >> $PRE_COMMIT_PATH
echo 'if [[ $MESSAGE != *fix* && $MESSAGE != *chore* && $MESSAGE != *test* && $MESSAGE != *feat* ]] || [[ $MESSAGE != *$TICKET* ]]; then' >> $PRE_COMMIT_PATH
echo '' >> $PRE_COMMIT_PATH
echo '	cat <<EOF' >> $PRE_COMMIT_PATH
echo 'Warning: Your commit message does not contain issue ticket number prefix $TICKET or does not include the' >> $PRE_COMMIT_PATH
echo 'correct tags: feat / fix / chore / test' >> $PRE_COMMIT_PATH
echo 'Please follow this link for more information:' >> $PRE_COMMIT_PATH
echo 'https://www.notion.so/wuerthcs/Git-77bb96afa65d40438e782d33aa93a6e2' >> $PRE_COMMIT_PATH
echo 'Are you sure you want to commit without it?' >> $PRE_COMMIT_PATH
echo 'If yes, use the following command:' >> $PRE_COMMIT_PATH
echo 'git commit --no-verify -m "commit message"' >> $PRE_COMMIT_PATH
echo 'EOF' >> $PRE_COMMIT_PATH
echo '  exit 1' >> $PRE_COMMIT_PATH
echo 'fi' >> $PRE_COMMIT_PATH

# Make the pre-commit file executable
chmod +x $PRE_COMMIT_PATH
