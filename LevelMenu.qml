import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtMultimedia

Rectangle
{
    anchors.fill: parent;
    color:"transparent";

    signal sonReturnSig();
    signal sonChoiceSig(int pos);

    Text
    {
        id: title
        text: qsTr("选择关卡");
        font.pixelSize: 60;
        font.bold: true;
        anchors.horizontalCenter: parent.horizontalCenter;
        color:"white";
    }

    SoundEffect
    {
        id:hoverVoice;
        source: "qrc:/new/prefix1/res/tipVoice.wav";
    }

    SoundEffect
    {
        id:clickVoice;
        source: "qrc:/new/prefix1/res/clickVoice.wav";
    }

    //
    GridView
    {
        id:gridview;
        anchors.top: title.bottom;
        anchors.right: parent.right;
        anchors.left: parent.left;
        anchors.bottom: parent.bottom;
        anchors.topMargin: 50;
        model:20;
        cellWidth: width/6;
        cellHeight: cellWidth;
        delegate: Rectangle
        {
            width:gridview.cellWidth;
            height:gridview.cellHeight;
            color:"transparent";

            InnerShadow
            {
                anchors.fill: outlinerec
                source: outlinerec;
                radius: 8;
                samples: 16;
                color:"gray";
                horizontalOffset: 0;
                verticalOffset: 0;
                spread: 0.4;
            }

            Rectangle
            {
                id:outlinerec;
                anchors.fill: parent;
                anchors.margins: 10;
                border.color: Qt.rgba(0,0,0,10);
                border.width: 1;
                color:"white";
                radius: 5;
                Behavior on scale {
                    NumberAnimation
                    {
                        duration: 80;
                    }
                }
                Text
                {
                    anchors.centerIn: parent;
                    text: index+1;
                    font.pixelSize: 40;
                    font.bold: true;
                }
                MouseArea
                {
                    anchors.fill: parent;
                    hoverEnabled: true;
                    onEntered:
                    {
                        parent.scale=1.1;
                        hoverVoice.stop();
                        hoverVoice.play();
                    }
                    onExited:
                    {
                        parent.scale=1;
                    }
                    onClicked:
                    {
                        clickVoice.stop();
                        clickVoice.play();
                        sonChoiceSig(index);
                    }
                }
            }
        }
    }


    //退出按钮
    Image
    {
        anchors.top: parent.top;
        anchors.right: parent.right;
        anchors.margins: 10;
        width: 40;
        height: 40;
        source: "/new/prefix1/res/exit.svg";
        ToolTip
        {
            id:exitTip;
            visible: false;
            text: "退出";
        }

        MouseArea
        {
            anchors.fill: parent;
            cursorShape: Qt.PointingHandCursor;
            hoverEnabled: true;
            onClicked:
            {
                sonReturnSig();
            }
            onEntered:
            {
                exitTip.visible=true;
            }
            onExited:
            {
                exitTip.visible=false;
            }
        }
    }//退出按钮
}
