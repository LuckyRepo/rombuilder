#/bin/bash
	clear
	echo -e '\e[104mRomBuilder by LuckyRepo v0.0.3\e[0m'
	echo -e '\e[91mThis build still contains test code. Not for daily use. Devs and testers Only.\e[0m'
# Set PATH for all REPO commands
	PATH=~/bin:$PATH
	echo -e '\e[32mChanged BIN Path to current folder to allow for Repo commands\e[0m'
# Set CCACHE up
		prebuilts/misc/linux-x86/ccache/ccache -M 100G
		export CCACHE_DIR=/CCACHE
		export USE_CCACHE=1
		export CCACHE_COMPRESS=1
    	echo -e '\e[32mSet CCACHE to 100G, set compression and set use to 1\e[0m'
# Set Jack server to use 6g to avoid build errors
		cd $PWD/prebuilts/sdk/tools
		./jack-admin stop-server
		export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx6g"
		./jack-admin start-server
            echo -e '\e[32mSet Jack Server to -Xmx6g\e[0m'
    cd $OLDPWD
# Ask if they want to sync in yes or no
	echo -e '\e[32mDo you wish to sync the repo?\e[0m'
	select yn in "Yes" "No"; do
    		case $yn in
        		Yes ) echo -e '\e[96mStarting Sync\e[0m'; repo sync --force-sync && break;;
        		No ) echo -e '\e[96mSkipping Sync\e[0m'; break;;
    		esac
	done
# Start Build
	    echo -e '\e[32mMarking start of build\e[0m'
            sleep 1
            source build/envsetup.sh
# Ask if they want lunch or brunch
	echo -e '\e[32mLunch or Brunch?\e[0m'
	select lb in "Lunch" "Brunch"; do
    		case $lb in
        		Lunch ) echo -e '\e[96mUsing Lunch\e[0m'; lunch && break;;
        		Brunch ) echo -e '\e[96mUsing Brunch\e[0m'; brunch && break;;
    		esac
	done
	    echo -e '\e[91mTurning controls back to you.\e[0m'
            exit
