#/bin/bash
	clear
	echo -e '\e[104mRomBuilder by LuckyRepo\e[0m'
	echo -e '\e[91mThis build still contains test code. Not for daily use. Devs and testers Only.\e[0m'
# Set PATH for all REPO commands
	PATH=~/bin:$PATH
	echo -e '\e[96mChanged BIN Path to current folder to allow for Repo commands\e[0m'
# Set CCACHE up
		prebuilts/misc/linux-x86/ccache/ccache -M 100G
		export CCACHE_DIR=/CCACHE
		export USE_CCACHE=1
		export CCACHE_COMPRESS=1
    	echo -e '\e[96mSet CCACHE to 100G, set compression and set use to 1\e[0m'
# Set Jack server to use 6g to avoid build errors
		cd $PWD/prebuilts/sdk/tools
		./jack-admin stop-server
		export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx6g"
		./jack-admin start-server
            echo -e '\e[32mSet Jack Server to -Xmx6g\e[0m'
    cd $OLDPWD
# Ask if they want to sync in yes or no
	read -p "Do you want to sync before building? y/n" syncchoice
	case "$syncchoice" in 
  		y|Y ) repo sync --forcesync;;
  		n|N ) echo -e '\e[96mSkipping Sync\e[0m';;
		b|B ) repo sync -c -f -j8 --force-sync --no-clone-bundle --no-tags
  	* ) echo "invalid";;
	esac
# Start Build leaving lunch and make for user
	    echo -e '\e[32mMarking start of build\e[0m'
            sleep 1
            source build/envsetup.sh
	    echo -e '\e[91mYou are now ready for lunch or brunch. Turning controls back to you.\e[0m'
            exit
