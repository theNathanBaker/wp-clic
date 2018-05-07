<?php

/*
Plugin Name: WP-CLIC
Plugin URI: https://wordpress.org/plugins/wp-clic/
Description: WP-CLIC provides a text based menu system for WP-CLI. This gives you the ease of use of a GUI, with the speed of WP-CLI.
Author: Nathan Baker
Author URI: https://theNathanBaker.com
Version: 1.0
Author URI: https://theNathanBaker.com/
Text Domain: wp-clic
License: GPLv2 or later
License URI: https://www.gnu.org/licenses/gpl-2.0.html
*/


defined( 'ABSPATH' ) or die( 'No script kiddies please!' );

//Places wpclic.sh in root directory
function wpclic_activate(){  
	$pluginDir = plugin_dir_path( __FILE__ );	
	copy($pluginDir .  'wp-clic.sh', ABSPATH . 'wp-clic.sh');	
	chmod(ABSPATH . 'wp-clic.sh', 0555);
}

//Removes wpclic.sh from root directory
function wpclic_deactivate() {
	unlink(ABSPATH . 'wp-clic.sh');
}

register_activation_hook( __FILE__, 'wpclic_activate' );
register_deactivation_hook( __FILE__, 'wpclic_deactivate' );