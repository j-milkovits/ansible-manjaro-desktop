#!bin/bash
source ./scripts/multiple-choice.sh


# System update
read -e -p "Do you want to start a full system upgrade? [Y/n] " -i 'Y' response

while true; do
  case "$response" in
      [yY][eE][sS]|[yY])
        echo "Starting full system upgrade..."
        sudo pacman -Syu
        break
        ;;
      *)
        echo "Continuing without system upgrade..."
        break
        ;;
  esac
done


# User Input
echo -e "\n"
echo "Enter the following information::"
#echo "Enter the following information [arrows:move - space:select - enter:continue]:"

echo -e "\n"
echo "Enter your username:"
read -e -p "Enter manjaro username: " user_login



# Usage Example
# OPTIONS_VALUES=("packages" "oh-my-zsh" "i3" "polybar")
# OPTIONS_LABELS=("packages" "oh-my-zsh" "i3" "polybar")

# for i in "${!OPTIONS_VALUES[@]}"; do
# 	#OPTIONS_STRING+="${OPTIONS_VALUES[$i]} (${OPTIONS_LABELS[$i]});"
# 	OPTIONS_STRING+="${OPTIONS_VALUES[$i]};"
# done

# prompt_for_multiselect SELECTED "$OPTIONS_STRING"

# for i in "${!SELECTED[@]}"; do
# 	if [ "${SELECTED[$i]}" == "true" ]; then
# 		CHECKED+=("${OPTIONS_VALUES[$i]},")
# 	fi
# done
# CHECKED=${CHECKED[@]::-1}
# echo "${CHECKED}"



# Install ansible
read -e -p "Do you want to install ansible + requirements? [Y/n] " -i 'Y' response

while true; do
  case "$response" in
      [yY][eE][sS]|[yY])
        echo "Installing ansible..."
        yay -S ansible-core
        ansible-galaxy collection install community.general
        ansible-galaxy collection install kewlfft.aur
        break
        ;;
      *)
        echo "Continuing without installing ansible..."
        break
        ;;
  esac
done


# Execute ansible
ansible-pull -K -U https://github.com/f-wichert/ansible-manjaro-desktop \
  -e "user_login=$user_login" \
  #-e "cron_job_name='first install'" \
  #-e "git_user_name=$git_user_name" \
  #-e "git_user_email=$git_user_email" \
  --tags all



# TODO: include userinput for specific tags

# use --tags "always" to run only the tasks tagged with "always" (basically the basic stuff)
# run without --tags to run everything

# use --check --diff to make a dry run and see what would change
