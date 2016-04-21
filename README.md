Primary Vagrant
=============

## Note

I've done some heavy updates to Primary Vagrant to utilize Ubuntu 14.04 as well as a few other goodies. If you don't want to or can't update for some reason you can find the old version in the [Precise](https://github.com/ChrisWiegman/Primary-Vagrant/tree/Precise) branch.

## Warning

Currently [Mailcatcher](http://mailcatcher.me) is partially broken due to a change in the required Ruby version for an upstream dependency. The catch is, I can't update Ruby as it breaks Puppet. As a new version of Ubuntu is due out in a few weeks (and it uses an appropriate version of Ruby) I've elected to wait to fix the problem until then. __For the time being you will need to run a 2nd ```vagrant provision``` or reload the vagrant box to finish the Mailcatcher installation. The warning message can then be ignored.__

## About

Primary Vagrant is intended for WordPress plugin, theme, and core development, as well as general PHP development, and can be used as a replacement for local development stacks such as MAMP, XAMPP, and others.

Although [Varying Vagrant Vagrants](https://github.com/Varying-Vagrant-Vagrants/VVV) by 10up is great (and I still use it for NGINX work), I wanted a few major changes. First, I wanted Apache instead of NGINX and, second, I wanted to use Puppet instead of Bash. Using VVV and Puppet as a base, this repository attempts to address their shortcomings for my own work with a Vagrant configuration that is ready to go for WordPress plugin or theme development.

The repository contains a basic Vagrant configuration that will configure the following goodies:

* Ubuntu 14.04 LTS
* [Apache](http://httpd.apache.org)
* [PHP](http://php.net) 5.6
* [MySQL](https://www.mysql.com)
* [Xdebug](http://xdebug.org)
* [PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)
* [WordPress Coding Standards](https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards) *for PHP_CodeSniffer*
* [PHPUnit](https://phpunit.de)
* [Postfix](http://www.postfix.org)
* [wp-cli](http://wp-cli.org)
* [phpMyAdmin](http://www.phpmyadmin.net)
* [WordPress](https://wordpress.org) (Last, Stable, Core, and Dev)
* Various debugging plugins for WordPress
* [Search Replace DB](http://interconnectit.com/products/search-and-replace-for-wordpress-databases/)
* [webgrind](https://github.com/jokkedk/webgrind/)
* [oh-my-zsh](http://ohmyz.sh)
* [MailCatcher](http://mailcatcher.me)
* Test data from [WP Test](http://wptest.io)
* [Composer](https://getcomposer.org)
* [node.js](https://nodejs.org)
* [Git](http://git-scm.com)
* [Subversion](https://subversion.apache.org)
* [Memcached](https://memcached.org/)
* [Redis](http://redis.io/)

## Contributors

* [ChrisWiegman](https://github.com/ChrisWiegman)
* [kraftner](https://github.com/kraftner)
* [michaelbeil](https://github.com/michaelbeil)
* [NikV](https://github.com/NikV)

## Want to help?

If you find any issues, please don't hesitate to submit a [pull request](https://github.com/ChrisWiegman/Primary-Vagrant/blob/master/CONTRIBUTING.md).

Current development of the project is focusing on instituting multiple PHP versions using (at least for now) [phpbrew](https://github.com/phpbrew/phpbrew). It needs a lot of work, so if you have a few minutes head on over to the [phpbrew puppet module](https://github.com/ChrisWiegman/puppet-phpbrew) and dig in.

## Getting Started

### Default domains

* pv - Default menu
* phpmyadmin.pv - phpMyAdmin
* replacedb.pv - Search Replace DB
* core.wordpress.pv - WordPress development (for core dev)
* legacy.wordpress.pv - Last version of WordPress (currently 4.4.x)
* stable.wordpress.pv - Latest WordPress stable (currently 4.5.x)
* trunk.wordpress.pv - WordPress trunk
* vip.wordpress.pv - Simulates the WordPress VIP environment for development without VIP Quickstart
* webgrind.pv - webgrind
* mailcatcher.pv - MailCatcher

### Install the software

Install [Vagrant](http://vagrantup.com), [VirtualBox](http://virtualbox.org), and the [VirtualBox extensions](https://www.virtualbox.org/wiki/Downloads) for your environment.

Once Vagrant is installed you'll want three plugins to update your local hosts, and update the VirtualBox Guest additions in the Ubuntu install and handle various tasks like backing up your databases when you're done for the day.

```vagrant plugin install vagrant-vbguest```

```vagrant plugin install vagrant-ghost```

```vagrant plugin install vagrant-triggers```

### Launch your VM

1. [Download](https://github.com/ChrisWiegman/Primary-Vagrant/archive/master.zip) or clone this repo onto your local machine:

    ```$ git clone --recursive https://github.com/ChrisWiegman/Primary-Vagrant.git PV```

    or

    ```$ git clone --recursive git@github.com:ChrisWiegman/Primary-Vagrant.git PV```

1. In a command prompt, change into the new directory with `cd PV`

1. Start the Vagrant environment with `vagrant up`
	- Be patient as the magic happens. This could take a while on the first run as your local machine downloads the required files.
	- Watch as the script ends, as an administrator or `su` ***password may be required*** to properly modify the hosts file on your local machine.

### Preconfigured Sites

The following websites come pre-configured in the system:

* [Default menu](http://pv)
* WordPress (last major release) at [http://legacy.wordpress.pv](http://legacy.wordpress.pv)
* WordPress (latest stable release) at [http://stable.wordpress.pv](http://stable.wordpress.pv)
* WordPress Trunk at [http://trunk.wordpress.pv](http://trunk.wordpress.pv)
* WordPress VIP Environment at [http://vip.wordpress.pv](http://vip.wordpress.pv)
* WordPress Core Development at [http://core.wordpress.pv](http://core.wordpress.pv)
* Search Replace DB [https://replacedb.pv](https://replacedb.pv)

*Note: WordPress Core dev is taken from git://develop.git.wordpress.org/. Only the src folder is mapped. You can manually set up a build site if desired.

### Configure Additional Sites

First, create a file called mappings in the userdata directory. This will map any sites you create to the appropriate folder on PV.

Example Mapping:

```
config.vm.synced_folder "/Users/MyUser/Sites/Mysite/htdocs", "/var/www/mysite.pv", :owner => "www-data", :mount_options => [ "dmode=775", "fmode=774"]
```

*Note that if you're working on a WordPress plugin or theme I would recommend to simply map it to the three pre-installed WordPress sites. This will make it easy for you to test it on multiple versions of WordPress.

Example:

```
config.vm.synced_folder "/Users/MyUser/my-awesome-plugin", "/var/www/legacy.wordpress.pv/htdocs/content/plugins/my-awesome-plugin", :owner => "www-data", :mount_options => [ "dmode=775", "fmode=774"]
config.vm.synced_folder "/Users/MyUser/my-awesome-plugin", "/var/www/stable.wordpress.pv/htdocs/content/plugins/my-awesome-plugin", :owner => "www-data", :mount_options => [ "dmode=775", "fmode=774"]
config.vm.synced_folder "/Users/MyUser/my-awesome-plugin", "/var/www/trunk.wordpress.pv/htdocs/content/plugins/my-awesome-plugin", :owner => "www-data", :mount_options => [ "dmode=775", "fmode=774"]
```

Next Edit **userdata/siteconf/``[your-site-domain].pp**. This is where you define virtualhosts and databases. Copy what is below and ask me if you have any questions. Of course these aren't the only configuration options you have either. You can find a [full list of Apache configuration options here](http://github.com/example42/puppet-apache) and a [full list of mysql configuration options here](https://github.com/puppetlabs/puppetlabs-mysql).

Example:

```
apache::vhost { 'mysite.pv':
    docroot                         => '/var/www/mysite.pv',
    directory                       => '/var/www/mysite.pv',
    directory_allow_override        => 'All',
    ssl                             => true,
    template                        => '/var/vagrant/conf/vhost.conf.erb',
}
```

``` mysql
mysql_database { 'mysite.pv':
    ensure  => 'present',
    charset => 'utf8',
    collate => 'utf8_general_ci',
    require => Class['mysql::server'],
}
```

*Note: I've provided a top-level wildcard SSL certificate. No further SSL certificate should be needed.

Finally, and you can do this two ways... If you've created your site as a folder in the Primary Vagrant www folder just add a file callend *pv-hosts* to it that includes the domain name(s) (one per line) for your project. If your site is outside of the Primary Vagrant folder I would recommend creating *www/my-sites/pv-hosts* to hold the domain names. This will make sure you can access your sites by whatever domain names you need.

After the configuration above has been added, simply run `vagrant halt` and then `vagrant up` to trigger the changes and host file updates.

### Changing configuration options

The default installation configuration is found in *provision/manifests/init.pp*. While you could edit this if you like I would, instead, recommend adding any additional configuration to *userdata/siteconf/custom.pp*

#### Change PHP Versions

To change from PHP 5.6 I recommend using a PGP package from [https://launchpad.net/~ondrej/+archive/php5](https://launchpad.net/~ondrej/+archive/php5). You can do so by adding ```apt::ppa { 'ppa:ondrej/php5': }``` to *userdata/siteconf/php.pp*. Make sure to choose the correct repository for the PHP version you want to use.

Note: this file can also be used to change any php.ini value following the example included in the file.

#### Database Access

You can access the database via ssh tunnel into the machine using the *pv* hostname, the username *vagrant*, the password *vagrant* for ssh, and the username *root* without a password for MySQL.

In addition to the *root* MySQL account the account *username* with the password *password* has also been created and has been granted all privileges.

#### Postfix Configuration

Postfix is configured and set to use your host computer as a mail relay. To receive messages you can use the built in [MailCatcher installation](http://mailcatcher.pv:1080) (this will prevent your real SMTP mail server and mailbox from getting too much abuse).

#### WP Test Data
WP Test can be installed via the instructions at (https://github.com/manovotny/wptest). Test data is found in *[Primary Vagrant Folder]/sites/wordpress/wptest* on your host machine.

#### WordPress VIP Development
Primary Vagrant contains a full environment to help you work on WordPress VIP powered to sites without the need for VIP Quickstart. To access:

**URL:** [http://vip.wordpress.pv](http://vip.wordpress.pv)

**Username:** admin

**Password:** password

#### node.js

The latest stable node.js version is installed, if you want to pre-install packages just add them to *userdata/siteconf/nodejs.pp*.

Example:

``` javascript
package { 'ungit':
  provider => npm,
  require  => Class['nodejs']
}
```

### Debugging Code ###

Primary Vagrant comes pre-configured with two awesome tools for helping debug your code. The first is [Xdebug](http://xdebug.org/) and the second is [PHP_Codesniffer](https://github.com/squizlabs/PHP_CodeSniffer) (which comes complete with the [WordPress coding standards](https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards) already pre-configured). While configuration is dependant on the code editor you use here are some notes that might help you get started with them.

* Xdebug uses VAGRANT_DEBUG as its IDE key
* Many modern tools will let you access both of these tools easily with just a bit of configuration. For example, [here's a great post on using remote debugging in PHPStorm.](http://blog.jetbrains.com/phpstorm/2015/07/remote-tools-via-remote-php-interpreters-in-phpstorm-9/)
* [PHPStorm configuration suggestions are in the wiki](https://github.com/ChrisWiegman/Primary-Vagrant/wiki/XDEBUG-Setup-in-PHPStorm).

You can now also turn xdebug on or off completely with the commands `xon` and `xoff`. This should help speed up complex composer or other operations.

For debugging APIs or any other situation where sending a cookie with your request isn't ideal you can also turn on auto-listening for xdebug in which case it will try to connect automatically, even without a cookie. To do this simply use the commands `xlon` and `xloff` to enable or disable auto-remote. Note that this is disabled by default.

###Keep your fork up to date with the PV `upstream/master` repo

* Configure a remote that points to the upstream repository in Git: `git remote add upstream https://github.com/ChrisWiegman/Primary-Vagrant.git`

See: https://help.github.com/articles/configuring-a-remote-for-a-fork

The following commands should bring you up to speed:
* `git checkout <localbranch>`
* `git stash` -- save local changes
* `git pull https://github.com/ChrisWiegman/Primary-Vagrant.git upstream/master`
* `git submodule update --recursive`
* `git stash pop` -- saved local changes are available to be committed
* Use `git merge tool` if you have any conflicts

See: https://www.atlassian.com/git/tutorials/syncing/git-pull

Now, you will be free to PR against Primary Vagrant.

### Contributions

Contributions are more than welcome. Please read our current [guidelines for contributing](CONTRIBUTING.md) to this repository. Many thanks in advance!

### Future Development

Some ideas I'm working on for future features:

* PHPBrew or a similar script that will allow you to change PHP versions on the fly.
* A site builder script that will let you avoid having to edit any text to add a new site.
* Anything else (applicable to the project) that the community would like to contribute.

## Note

This server configuration is designed for development use only. Please don't put it on a production server as some of these settings would cause serious security issues.
