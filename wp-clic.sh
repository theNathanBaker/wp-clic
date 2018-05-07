#!/bin/bash

aboutMenu() {

	clear
	echo ""
	echo "+------------- About -------------+"
	echo "|     WP-CLI Companion v.1.0      |"
	echo "+---------------------------------+"
	echo ""
	echo "Author: Nathan Baker"
	echo "Email: theNathanBaker@gmail.com"
	echo "Websites: https://theNathanBaker.com"
	echo ""
	echo ""
	echo "Description:"
	echo ""
	echo "Thank you for using WP-CLI Companion!"
	echo ""
	echo "WP-CLIC provides a text based menu system for"
	echo "WP-CLI while maintaining the speed of CLI."
	echo ""
	echo "If you have any bug reports, feature requests, or general comments"
	echo "I would love to hear them! Email me at 'theNathanBaker@gmail.com'"
	echo ""
	echo "If you would like to support development of this project then"
	echo "contact me or send a donation to 'theNathanBaker@gmail.com' via Paypal"
	echo ""
	echo ""
	echo ""
	echo ""
	echo "------ Back to Main Menu ------"
	OPTIONS="Main_Menu"
	PS3="Option: "
	select opt in $OPTIONS
		do
			if [ "$opt" = "Main_Menu" ]
				then
					mainMenu;
			else
				echo "Invalid Option";
			fi
		done

}

# Settings Menu

settingsMenu() {

	############# General Settings #############
	generalSettings () {
		echo ""
		echo "------ General Settings ------"
		OPTIONS="Site_Title Tagline Wordpress_URL Site_Address Membership Default_User_Role Back"
			select opt in $OPTIONS
			do
				###### Back ######
				if [ "$opt" = "Back" ]
					then
						break;
						
				###### Site Title ######
				elif [ "$opt" = "Site_Title" ]
					then
						echo ""
						echo -n "Site title: " ; wp option get blogname;
						echo "Change site title?"
						OPTIONS="Yes No"
							select opt in $OPTIONS
							do
								if [ "$opt" = "No" ]
									then
										break;
								elif [ "$opt" = "Yes" ]
									then
										read -p "New site title: " newTitle;
										wp option update blogname "$newTitle";
										break;
								else
									echo "Invalid Option";
								fi
							done				
							generalSettings;
							
				###### Tagline ######
				elif [ "$opt" = "Tagline" ]
					then
						echo ""
						echo -n "Tagline: " ; wp option get blogdescription;
						echo "Change site tagline?"
						OPTIONS="Yes No"
							select opt in $OPTIONS
							do
								if [ "$opt" = "No" ]
									then
										break;
								elif [ "$opt" = "Yes" ]
									then
										read -p "New site tagline: " newTagline;
										wp option update blogdescription "$newTagline";
										break;
								else
									echo "Invalid Option";
								fi
							done				
							generalSettings;
							
				###### Wordpress URL ######
				elif [ "$opt" = "Wordpress_URL" ]
					then
						echo ""
						echo -n "Wordpress URL: " ; wp option get siteurl;
						echo "Change Wordpress URL?"
						OPTIONS="Yes No"
							select opt in $OPTIONS
							do
								if [ "$opt" = "No" ]
									then
										break;
								elif [ "$opt" = "Yes" ]
									then
										read -p "New Wordpress URL: " siteURL;
										wp option update siteurl "$siteURL";
										break;
								else
									echo "Invalid Option";
								fi
							done				
							generalSettings;
							
				###### Site Address ######
				elif [ "$opt" = "Site_Address" ]
					then
						echo ""
						echo -n "Site Address: " ; wp option get home;
						echo "Change Site Address?"
						OPTIONS="Yes No"
							select opt in $OPTIONS
							do
								if [ "$opt" = "No" ]
									then
										break;
								elif [ "$opt" = "Yes" ]
									then
										read -p "New Site Address: " siteURL;
										wp option update home "$siteURL";
										break;
								else
									echo "Invalid Option";
								fi
							done				
							generalSettings;
							
				###### Membership ######
				elif [ "$opt" = "Membership" ]
					then
						echo ""
						echo "Allow anyone to register?"
						OPTIONS="Yes No"
							select opt in $OPTIONS
							do
								if [ "$opt" = "No" ]
									then
										wp option update users_can_register 0;
										break;
								elif [ "$opt" = "Yes" ]
									then
										wp option update users_can_register 1;
										break;
								else
									echo "Invalid Option";
								fi
							done
							generalSettings;
							
				###### Default User Role ######
				elif [ "$opt" = "Default_User_Role" ]
					then
						echo ""
						echo -n "Current default user role: " ; wp option get default_role;
						echo "Change?"
						OPTIONS="Yes No"
							select opt in $OPTIONS
							do
								if [ "$opt" = "No" ]
									then
										break;
								elif [ "$opt" = "Yes" ]
									then
										wp role list;
										read -p "New default user role: " defaultRole;
										wp option update default_role "$defaultRole";
										break;
								else
									echo "Invalid Option";
								fi
							done
							generalSettings;
							
				###### Invalid Option ######
				else
					echo "Invalid Option";
				fi
			done
			settingsMenu;		
	}

	############# End General Settings #############


	readingSettings () {
		echo ""
		echo "------ Reading Settings ------"
		OPTIONS="Search_Engine_Visibility Back"
	PS3="Option: "
		select opt in $OPTIONS 
		do
	        if [ "$opt" = "Back" ] 
	        	then
	                break;
	        elif [ "$opt" = "Search_Engine_Visibility" ]
	        	then
	        		echo ""
	                echo "Discourage Search Engines?";
	                OPTIONS="Yes No"
	                	select opt in $OPTIONS
	                	do
	                		if [ "$opt" = "No" ]
	                			then
	                				wp option update blog_public 1;
	                				break;
	                		elif [ "$opt" = "Yes" ]
	                			then
	                				wp option update blog_public 0;
	                				break;
	                		else
	                			echo "Invalid Option";
	                		fi
	                	done
	                	readingSettings;
	         else
	            echo "Invalid Option";
	        fi
	    done
	    settingsMenu;
		
	}


	############# Settings Menu #############
	echo ""
	echo "------------- SETTINGS MENU -------------"
	echo ""

	OPTIONS="General Reading Main_Menu"
	PS3="Option: "
		select opt in $OPTIONS 
		do
	        if [ "$opt" = "Main_Menu" ] 
	        	then
	                break;
	        elif [ "$opt" = "General" ]
	        	then
	                generalSettings;
	        elif [ "$opt" = "Reading" ]
	        	then
	                readingSettings;
	        else
	            echo "Invalid Option";
	        fi
	    done
	    mainMenu;
	############# End Settings Menu #############

}

# Users Menu

usersMenu() {

	createUser () {
		read -p "User Login: " userLogin;
		read -p "User Password: " userPass;
		read -p "User Email: " userEmail;
		wp role list;
		read -p "User Role: " userRole;
		echo ""
		echo "Are these settings correct?";
		echo "User Login:" $userLogin;
		echo "User Password:" $userPass;
		echo "User Email:" $userEmail;
		echo "User Role:" $userRole;
		echo ""
			OPTIONS="Yes No Cancel"
				select opt in $OPTIONS
				do
					if [ "$opt" = "Cancel" ]
						then
							break;						
					elif [ "$opt" = "Yes" ]
						then
							wp user create "$userLogin" "$userEmail" --user_pass="$userPass" --role="$userRole";
							break;
					elif [ "$opt" = "No" ]
						then
							createUser;
					else
						echo "Invalid Option";
					fi
				done
				usersMenu;
		
	}

	userInfo () {
		wp user list;
		read -p "Enter user ID, login, or email: " userID;
		wp user get "$userID";
		usersMenu;
	}

	deleteUser () {
		read -p "Enter user ID, login, or email: " userID;
		OPTIONS="Reassign_Content_to_New_User Delete_Associated_Content Cancel"
			select opt in $OPTIONS
			do
				if [ "$opt" = "Cancel" ]
					then
						break;
				elif [ "$opt" = "Reassign_Content_to_New_User" ]
					then
						wp user list;
						read -p "User to assign content to: " reassignID;
						wp user delete "$userID" --reassign="$reassignID";
						break;
				elif [ "$opt" = "Delete_Associated_Content" ]
					then
						wp user delete "$userID" --yes;
						break;
				else 
					echo "Invalid Option";
				fi
			done
			usersMenu;		
	}

	setRole () {
		wp user list;
		read -p "Select User: " userID;
		wp role list;
		read -p "Select Role: " roleID;
		wp user set-role "$userID" "$roleID";
		usersMenu;
	}

	echo ""
	echo "------------- USERS MENU -------------"
	echo ""

	OPTIONS="List Create Info Delete Set_Role Main_Menu"
	PS3="Option: "
		select opt in $OPTIONS 
		do
	        if [ "$opt" = "Main_Menu" ] 
	        	then
	                break;
	        elif [ "$opt" = "List" ]
	        	then
	                wp user list;
	        elif [ "$opt" = "Create" ]
	        	then
	            	createUser;
	        elif [ "$opt" = "Info" ]
	        	then
	                userInfo;
	        elif [ "$opt" = "Delete" ]
	        	then
	                deleteUser;
	        elif [ "$opt" = "Set_Role" ]
	        	then
	            	setRole;
	        else
	            echo "Invalid Option";
	        fi
	    done
	    mainMenu;


}

# Plugin Menu

pluginMenu() {

	echo ""
	echo "------------- PLUGIN MENU -------------"
	echo ""

	OPTIONS="List Activate Deactivate Info Search Install Uninstall Main_Menu"
	PS3="Option: "
		select opt in $OPTIONS 
		do
	        if [ "$opt" = "Main_Menu" ] 
	        	then
	                break;
	        elif [ "$opt" = "List" ]
	        	then
	                wp plugin list;
	        elif [ "$opt" = "Activate" ]
	        	then
	            	read -p "Name of plugin: " pluginName;
	            	wp plugin activate "$pluginName";
	        elif [ "$opt" = "Deactivate" ]
	        	then
	                read -p "Name of plugin: " pluginName;
	                wp plugin deactivate "$pluginName";
	        elif [ "$opt" = "Info" ]
	        	then
	                read -p "Name of plugin: " pluginName;
	                wp plugin get "$pluginName";
	        elif [ "$opt" = "Search" ]
	        	then
	               read -p "Search terms: " searchTerms;
						wp plugin search "$searchTerms";
	        elif [ "$opt" = "Install" ]
	        	then
	            	read -p "Name or slug of plugin: " pluginID;
	            	wp plugin install "$pluginID";
	        elif [ "$opt" = "Uninstall" ]
	        	then
	                read -p "Plugin: " pluginName;
	                wp plugin uninstall "$pluginName";
	        else
	            echo "Invalid Option";
	        fi
	    done
	    mainMenu;


}

# Appearance Menu

appearanceMenu() {

	manageTheme () {
		echo ""
		echo "------ Theme Menu ------"
		OPTIONS="List Activate Get_Info Delete Search_for_themes Install Back"
			select opt in $OPTIONS
			do 
				if [ "$opt" = "Back" ]
					then
						break;
				elif [ "$opt" = "List" ]
					then
						wp theme list;
						manageTheme;
				elif [ "$opt" = "Activate" ]
					then
						read -p "Name of theme: " themeID;
						wp theme activate $themeID;
				elif [ "$opt" = "Get_Info" ]
					then
						read -p "Name of theme: " themeID;
						wp theme get $themeID;
				elif [ "$opt" = "Delete" ]
					then
						read -p "Name of theme: " themeID;
						wp theme delete $themeID;
				elif [ "$opt" = "Search_for_themes" ]
					then
						read -p "Search terms: " searchTerms;
						wp theme search "$searchTerms";
				elif [ "$opt" = "Install" ]
					then
						read -p "Name of theme: " themeID;
						wp theme install $themeID;
				else
					echo "Invalid Option";
				fi
			done
			appearanceMenu;
		
	}


	manageMenu () {

		editMenu () {
			read -p "Menu name: " menuName;
			OPTIONS="List_menu_items Add_page_to_menu Add_custom_link_to_menu Delete_item_from_menu Back"
				select opt in $OPTIONS
				do
					if [ "$opt" = "Back" ]
						then
							break;
					elif [ "$opt" = "List_menu_items" ]
						then
							wp menu item list "$menuName";
					elif [ "$opt" = "Add_page_to_menu" ]
						then
							wp post list --post_type=page;
							read -p "Enter page ID: " pageID;
							read -p "Item title: " itemTitle;
							wp menu item add-post --title="$itemTitle" "$menuName" $pageID;
					elif [ "$opt" = "Add_custom_link_to_menu" ]
						then
							read -p "Menu item title: " itemTitle;
							read -p "URL: " url;
							wp menu item add-custom "$menuName" "$itemTitle" "$url";
					elif [ "$opt" = "Delete_item_from_menu" ]
						then
							wp menu item list "$menuName";
							read -p "Enter db_id of menu item: " dbID;
							wp menu item delete $dbID;
					else
						echo "Invalid Option";
					fi
				done
				manageMenu;
		}

		echo ""
		echo "------ Manage Menus ------"
		OPTIONS="List Create Edit Delete Back"
			select opt in $OPTIONS
			do 
				if [ "$opt" = "Back" ]
					then
						break;
				elif [ "$opt" = "List" ]
					then
						wp menu list;
						manageMenu;
				elif [ "$opt" = "Create" ]
					then
						read -p "Menu name: " menuName;
						wp menu create "$menuName";
				elif [ "$opt" = "Edit" ]
					then
						wp menu list;
						editMenu;
				elif [ "$opt" = "Delete" ]
					then
						read -p "Menu name: " menuName;
						wp menu delete "$menuName";
				else
					echo "Invalid Option";
				fi
			done
			appearanceMenu;
		
	}

	###### Appearance Menu ######
	echo ""
	echo "------------- APPEARANCE MENU -------------"
	echo ""

	OPTIONS="Theme Menu Widgets Main_Menu"
	PS3="Option: "
		select opt in $OPTIONS 
		do
	        if [ "$opt" = "Main_Menu" ]
	        	then
	        		mainMenu;
	        elif [ "$opt" = "Theme" ] 
	        	then
	                manageTheme;
	        elif [ "$opt" = "Menu" ]
	        	then
	            	manageMenu;
	        elif [ "$opt" = "Widgets" ]
	        	then
	            	echo "This Feature Is Still Under Development";
	        else
	            echo "Invalid Option";
	        fi
	    done
	    
	###### End Appearance Menu ######

}

# Comments Menu

commentsMenu() {

	listComment () {
		wp comment list;
	}

	manageComment () {
		read -p "Enter comment ID: " commentID;
		
		OPTIONS="View_Comment Approve Delete Spam Unapprove Unspam Untrash Back"
			select opt in $OPTIONS
			do 
				if [ "$opt" = "Back" ]
					then
						break;
				elif [ "$opt" = "View_Comment" ]
					then
						wp comment get $commentID;
				elif [ "$opt" = "Approve" ]
					then
						wp comment approve $commentID;
				elif [ "$opt" = "Delete" ]
					then
						wp comment delete $commentID;
				elif [ "$opt" = "Spam" ]
					then
						wp comment spam $commentID;
				elif [ "$opt" = "Unapprove" ]
					then
						wp comment unapprove $commentID;
				elif [ "$opt" = "Unspam" ]
					then
						wp comment unspam $commentID;
				elif [ "$opt" = "Untrash" ]
					then
						wp comment untrash $commentID;
				else
					echo "Invalid Option";
				fi
			done
			commentsMenu
	}

	echo ""
	echo "------------- COMMENTS MENU -------------"
	echo ""

	wp comment count
	echo ""
	OPTIONS="List_Comments Manage_Comment Main_Menu"
	PS3="Option: "
		select opt in $OPTIONS 
		do
	        if [ "$opt" = "Main_Menu" ] 
	        	then
	                mainMenu;
	        elif [ "$opt" = "List_Comments" ]
	        	then
	                listComment;
	        elif [ "$opt" = "Manage_Comment" ]
	        	then
	            	manageComment;
	        else
	            echo "Invalid Option";
	        fi
	    done

}

# Pages Menu

pagesMenu() {

	echo ""
	echo "------------- PAGES MENU -------------"
	echo ""

	getPageInfo () {
		wp post list --post_type=page;
		read -p "Enter page ID: " pageID;
		wp post get $pageID;
	}

	createPage () {
		read -p "Page title: " pageTitle;
		wp post create --post_title="$pageTitle" --post_type=page --post_status=publish --edit;
	}

	editPage () {
		wp post list --post_type=page;
		read -p "Enter page ID: " pageID;
		wp post edit $pageID;
	}

	deletePage () {
		wp post list --post_type=page;
		read -p "Enter page ID: " pageID;
		wp post delete $pageID;
	}

	updatePage () {
		wp post list --post_type=page;
		read -p "Enter page ID of the page you wish to update: " pageID;
		wp user list;
		read -p "Enter ID of author: " authorID;
		echo "Select status of page:";
		 OPTIONS="Publish Draft"
		 select opt in $OPTIONS
		 do
		 	if [ "$opt" = "Publish" ] 
		 		then
		 			postStatus=publish;
		 			break;
		 	elif [ "$opt" = "Draft" ]
		 		then
		 			postStatus=draft;
		 			break;
		 	else
		 		echo "Invalid Option";
		 	fi
		 done
		 wp post update $pageID --post_author=$authorID --post_status=$postStatus;
			
	}

	OPTIONS="List_Pages Get_Page_Info Create_Page Edit_Page Delete_Page Update_Page Main_Menu"
	PS3="Option: "
		select opt in $OPTIONS 
		do
	        if [ "$opt" = "Main_Menu" ] 
	        	then
	                mainMenu
	        elif [ "$opt" = "List_Pages" ]
	        	then
	                wp post list --post_type=page;
	        elif [ "$opt" = "Get_Page_Info" ]
	        	then
	            	getPageInfo;
	        elif [ "$opt" = "Create_Page" ]
	        	then
	                createPage;
	        elif [ "$opt" = "Edit_Page" ]
	        	then
	                editPage;
	        elif [ "$opt" = "Delete_Page" ]
	        	then
	            	deletePage;
	        elif [ "$opt" = "Update_Page" ]
	        	then
	                updatePage;
	        else
	            echo "Invalid Option";
	        fi
	    done

}

# Posts Menu

postMenu() {

	echo ""
	echo "------------- POSTS MENU -------------"
	echo ""

	getPostInfo () {
		wp post list;
		read -p "Enter post ID: " postID;
		wp post get $postID;
	}

	createPost () {
		read -p "Post title: " postTitle;
		wp post create --post_title="$postTitle" --post_type=post --post_status=publish --edit;
	}

	editPost () {
		wp post list;
		read -p "Enter post ID: " postID;
		wp post edit $postID;
	}

	deletePost () {
		wp post list;
		read -p "Enter post ID: " postID;
		wp post delete $postID;
	}

	updatePost () {
		wp post list;
		read -p "Enter post ID of the post you wish to update: " postID;
		wp user list;
		read -p "Enter ID of author: " authorID;
		echo "Select status of post:"
		 OPTIONS="Publish Draft"
		 select opt in $OPTIONS
		 do
		 	if [ "$opt" = "Publish" ] 
		 		then
		 			postStatus=publish;
		 			break;
		 	elif [ "$opt" = "Draft" ]
		 		then
		 			postStatus=draft;
		 			break;
		 	else
		 		echo "Invalid Option";
		 	fi
		 done
		 wp post update $postID --post_author=$authorID --post_status=$postStatus;
			
	}

	OPTIONS="List_Posts Get_Post_Info Create_Post Edit_Post Delete_Post Update_Post Main_Menu"
	PS3="Option: "
		select opt in $OPTIONS 
		do
	        if [ "$opt" = "Main_Menu" ] 
	        	then
	                mainMenu
	        elif [ "$opt" = "List_Posts" ]
	        	then
	                wp post list;
	        elif [ "$opt" = "Get_Post_Info" ]
	        	then
	            	getPostInfo;
	        elif [ "$opt" = "Create_Post" ]
	        	then
	                createPost;
	        elif [ "$opt" = "Edit_Post" ]
	        	then
	                editPost;
	        elif [ "$opt" = "Delete_Post" ]
	        	then
	            	deletePost;
	        elif [ "$opt" = "Update_Post" ]
	        	then
	                updatePost;
	        else
	            echo "Invalid Option"
	        fi
	    done

}


# Update Menu

updateMenu() {

	echo ""
	echo "------------- UPDATE MENU -------------"
	echo ""

	OPTIONS="Check_Status Update_Wordpress Update_Plugins Update_Themes Main_Menu"
	PS3="Option: "
		select opt in $OPTIONS 
		do
	        if [ "$opt" = "Main_Menu" ] 
	        	then
	                mainMenu;
	        elif [ "$opt" = "Check_Status" ]
	        	then
	                wp core check-update;
	                wp plugin list;
	                wp theme list;
	        elif [ "$opt" = "Update_Wordpress" ]
	        	then
	            	wp core update;
	        elif [ "$opt" = "Update_Plugins" ]
	        	then
	                wp plugin update --all;
	        elif [ "$opt" = "Update_Themes" ]
	        	then
	                wp theme update --all;
	        else
	            echo "Invalid Option"
	        fi
	    done

}


# Main Menu 

start() {

	clear

	echo ""
	echo "+---------------------------------------+"
	echo "|        WP-CLI Companion  v.1.0        |"
	echo "+---------------------------------------+"
	echo ""

	mainMenu;

}

# Main Menu

mainMenu() {

	echo ""
	echo "------------- MAIN MENU -------------"
	echo ""

	OPTIONS="Home Updates Posts Pages Comments Appearance Plugins Users Settings About Quit"
	PS3="Option: "
		select opt in $OPTIONS 
		do
	        if [ "$opt" = "Quit" ] 
	        	then
	                echo Done;
	                exit
	        elif [ "$opt" = "Home" ]
	        	then
	                mainMenu;
	        elif [ "$opt" = "Updates" ]
	        	then
	            	updateMenu;
	        elif [ "$opt" = "Posts" ]
	        	then
	                postMenu;
	        elif [ "$opt" = "Pages" ]
	        	then
	                pagesMenu;
	        elif [ "$opt" = "Comments" ]
	        	then
	            	commentsMenu;
	        elif [ "$opt" = "Appearance" ]
	        	then
	                appearanceMenu;
	        elif [ "$opt" = "Plugins" ]
	        	then
	            	pluginMenu;
	        elif [ "$opt" = "Users" ]
	        	then
	                usersMenu;
	        elif [ "$opt" = "Settings" ]
	        	then
	                settingsMenu;
	        elif [ "$opt" = "About" ]
	        	then
	            	aboutMenu;
	        else
	            echo "Invalid Option"
	        fi
	    done

}


# Start Program
start;