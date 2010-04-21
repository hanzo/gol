#!/bin/sh


# -- change to the platform you are running on (iphone, desktop or web) --
platform="iphone"
# ------------------------------------------------------------------------



IFS="$(echo -e "\n\r")"
projectPath=`dirname $0`
codePath=$projectPath/Resources/main
codeFile=$codePath/main.pde
dataPath=$codePath/data
code=""
code=`cat $codeFile`
cd $codePath
echo "<html>" > main.html
echo "<head>" >> main.html
echo "<meta name=\"viewport\" content=\"width=320; user-scalable=no\" />" >> main.html
echo "<meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\">" >> main.html
echo "<script type=\"text/javascript\" src=\"libraries/Processing/init.js\"></script>" >> main.html
echo "<script type=\"text/javascript\" src=\"libraries/Processing/iprocessing.js\"></script>" >> main.html
echo "</head>" >> main.html
echo "<body style=\"margin:0px;padding:0px;background-color:#000000;-webkit-user-select:none;\">" >> main.html
if [ $platform = "iphone" ] ; then
	echo "<div id=\"default\" style=\"margin:0px;padding:0px;height:460px;width:320px;visibility:visible;\">" >> main.html
	echo "<img id=\"Default.png\" src=\"Default.png\"/>" >> main.html
	echo "</div>" >> main.html
fi
echo "<div id=\"data\" style=\"margin:0px;padding:0px;height:0px;width:0px;visibility:hidden;\">" >> main.html
cd $dataPath
for file in *.jpg
do
	#if [ $file != "*.jpg" ] ; then
		echo "<img id=\"$file\" src=\"data/$file\"/>" >> $codePath/main.html
	#fi
done
for file in *.png
do
	if [ $file != "*.png" ] ; then
		echo "<img id=\"$file\" src=\"data/$file\"/>" >> $codePath/main.html
	fi
done
for file in *.gif
do
	if [ $file != "*.gif" ] ; then
		echo "<img id=\"$file\" src=\"data/$file\"/>" >> $codePath/main.html
	fi
done
for file in *.tga
do
	if [ $file != "*.tga" ] ; then
		echo "<img id=\"$file\" src=\"data/$file\"/>" >> $codePath/main.html
	fi
done
cd $codePath
echo "</div>" >> main.html
echo "<script id=\"platform\">${platform}</script>" >> main.html
echo "<script id=\"code\" type=\"application/processing\">" >> main.html
echo "<!-- ************** PROCOCESSING ***************************************************************************************************************************** -->" >> main.html
echo " " >> main.html
echo " " >> main.html
echo "$code" >> main.html
echo " " >> main.html
echo " " >> main.html
echo "<!-- ************** PROCOCESSING ***************************************************************************************************************************** -->" >> main.html
echo "</script><canvas id=\"canvas\"></canvas>" >> main.html 
echo "<div id=\"debug\" style=\"font-family:courier;color:#FFFFFF;\"></div>" >> main.html
echo "</body>" >> main.html
echo "</html>" >> main.html
if [ $platform = "desktop" ] ; then
		open main.html
elif [ $platform = "web" ] ; then
		open main.html
fi