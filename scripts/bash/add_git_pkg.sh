cd $1
git init
git add .
git commit -m "$2"
cd ..
git clone --bare $1 /opt/git/$1.git
rm -rf $1
sudo mv /opt/git/$1.git/hooks/post-update.sample /opt/git/$1.git/hooks/post-update; sudo chmod a+x /opt/git/$1.git/hooks/post-update;
cd /opt/git/$1.git/; sudo git update-server-info;
