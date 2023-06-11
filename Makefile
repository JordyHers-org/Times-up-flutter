#--------------------------------------------------------------------------
#
# The make file is used to quickly run commands to help unify
# our workflow and avoid typing longer commands. Please add here useful
# commands and do not forget to write a comment to explain how this command
# works and what it does. Update Readme File if necessary.
#
#--------------------------------------------------------------------------


# Make revert soft commit
revert:
	git reset --soft HEAD^1

# Cleans the project
clean:
	flutter clean && flutter pub get

# Deploy will make sure fastlane release is triggered
deploy:
	make clean && make release

# This command will clean, delete .dart_tool and generate
# classes.
generate:
	flutter packages pub run build_runner build --delete-conflicting-outputs

#This command runs fastlane
release:
	fastlane release
	
dev:
	git checkout dev

master:
	git chechout master
