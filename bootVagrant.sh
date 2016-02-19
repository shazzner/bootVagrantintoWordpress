#!/bin/bash

# Boots a Vagrant Instance into Wordpress
# See README.md for more details and usage

#Config
BOX="ubuntu/trusty64"

if [ -z $1 ]
then
    echo "No path name specified, please give your project a name ie. 'Wordpress-Dev'"
    exit 1
fi

read -p "This will create a new vagrant wordpress box. This may take some time, are you sure? [y/n]" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo "Exiting!"
    exit 1
fi

echo "Creating Vagrant Host $1"

if [ -d "./$1" ]
then
   echo "ERR: Folder already exists"
   exit 1
fi

mkdir ./$1

(cd ./$1/; vagrant init)
(cd ./$1/; vagrant box add $BOX)
(cd ./$1/; sed -i "s@base@$BOX@g" ./Vagrantfile)
(cd ./$1/; sed -i 's/# config.vm.network "forwarded_port"/config.vm.network "forwarded_port"/g' ./Vagrantfile)

(cd ./$1/; sed -i -f - ./Vagrantfile &> /dev/null <<EOF
/^end$/ i\\
  config.berkshelf.enabled = true \\
  config.vm.provision "chef_solo" do |chef| \\
    chef.cookbooks_path = [ "../cookbooks", "site_cookbooks" ] \\
    chef.add_recipe "wordpress" \\
    chef.json = { \\
      mysql: { \\
        server_root_password: 'rootpass', \\
        server_debian_password: 'debpass', \\
        server_repl_password: 'replpass' \\
      } \\
    } \\
    chef.run_list = [ \\
      'recipe[wordpress::default]' \\
    ] \\
  end \\  
end \\
EOF
)

cp ./cookbooks/wordpress/metadata.rb ./$1/
cp ./cookbooks/wordpress/README.md ./$1/
cp ./cookbooks/wordpress/Berksfile ./$1/
cp ./cookbooks/wordpress/Gemfile ./$1/
cp -r ./cookbooks/wordpress/attributes ./$1/
cp -r ./cookbooks/wordpress/libraries ./$1/
cp -r ./cookbooks/wordpress/recipes ./$1/
cp -r ./cookbooks/wordpress/templates ./$1/
cp -r ./cookbooks/wordpress/attributes ./$1/

(cd ./$1/; vagrant up)

echo "Vagrant Box is up!"
