git init
git add .
git commit -m 'initial project version'
git clone --bare Gallery_Interface_Bulider_Plugin_HTML_Albums /opt/git/Gallery_Interface_Bulider_Plugin_HTML_Albums.git
rm -rf Gallery_Interface_Bulider_Plugin_HTML_Albums
sudo mv /opt/git/Gallery_Interface_Bulider_Plugin_HTML_Albums.git/hooks/post-update.sample /opt/git/Gallery_Interface_Bulider_Plugin_HTML_Albums.git/hooks/post-update; sudo chmod a+x /opt/git/Gallery_Interface_Bulider_Plugin_HTML_Albums.git/hooks/post-update;
cd /opt/git/Gallery_Interface_Bulider_Plugin_HTML_Albums.git/; sudo git update-server-info;
