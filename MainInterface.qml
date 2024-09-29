import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle
{
    id:backgroundRect;
    color: "white";
    Image
    {
        id:backgroundImage;
        source: "/new/prefix1/res/background.jpg";
        anchors.fill: parent;
    }

    signal cloSig();
    signal returnSig();
    signal checkStateSig();
    signal allOkSig();

    onCheckStateSig: function()
    {
        for(var i=0;i<16;i++)
        {
            if(gridview.itemAtIndex(i).visible===true)
            {
                if(!gridview.itemAtIndex(i).checkRotation())
                {
                    return;
                }
            }
        }
        console.log("allok");
        allOkSig();
    }

    onReturnSig:function()
    {
        gameMenu.visible=true;
        ruleInterface.visible=false;
        gaming.visible=false;
    }

    GameMenu
    {
        id:gameMenu;
        anchors.fill: parent;
        onSonCloSig:function()
        {
            cloSig();
        }
        onSonStartSig: function()
        {
            gameMenu.visible=false;
            ruleInterface.visible=false;
            gaming.visible=true;
        }
        onSonRuleSig:function()
        {
            gameMenu.visible=false;
            ruleInterface.visible=true;
            gaming.visible=false;
        }
    }

    Rectangle
    {
        id:gaming;
        anchors.fill: parent;
        color:"transparent";
        visible: false;
        signal returnSig();

        Image
        {
            anchors.top: parent.top;
            anchors.right: parent.right;
            anchors.margins: 10;
            width: 35;
            height: 35;
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
                    backgroundRect.returnSig();
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

        GridView
        {
            id:gridview;
            anchors.fill: parent;
            anchors.topMargin: 60;
            model: 16;
            cellWidth: 150;
            cellHeight : 200;
            boundsBehavior:Flickable.StopAtBounds;
            delegate: Rectangle
            {
                id:outlinerec;
                width: 150;
                height: 200;
                color:"transparent";
                visible:true;

                property var dx:[-1,4,1,-4];
                property bool isclicked: false;

                onIsclickedChanged:function()
                {
                    console.log(index);
                }

                function setRotation()
                {
                    rotate.angle+=180;
                }

                function checkRotation()
                {
                    if(rotate.angle/180%2===0)
                        return false;
                    else return true;
                }

                Flipable
                {
                    id:flipable;
                    anchors.fill: parent;
                    front: Image {
                        anchors.fill: parent;
                        source: "/new/prefix1/res/card.png";
                    }

                    back: Image {
                        anchors.fill: parent;
                        source: "/new/prefix1/res/Turnedcard.png";
                    }

                    transform: Rotation {
                        id:rotate;
                        origin.x: flipable.width/2;
                        origin.y: flipable.height/2;
                        angle: 0;
                        axis.x:0;
                        axis.y:1;
                        axis.z:0;

                        Behavior on angle {
                            NumberAnimation
                            {
                                duration: 80;
                            }
                        }
                    }

                    MouseArea
                    {
                        anchors.fill: parent;
                        onClicked:
                        {
                            rotate.angle+=180;
                            for(var i=0;i<4;i++)
                            {
                                var a=index+dx[i];
                                if(0<=a&&a<=15)
                                {
                                    gridview.itemAtIndex(a).setRotation();
                                }
                            }
                            checkStateSig();

                        }
                    }//鼠标区域
                }//flipable
            }//delegate
        }//GridView
    }//游戏界面


    Rectangle
    {
        id:ruleInterface;
        anchors.fill: parent;
        color:"transparent";
        visible: false;

        Image
        {
            anchors.top: parent.top;
            anchors.right: parent.right;
            anchors.margins: 10;
            width: 35;
            height: 35;
            source: "/new/prefix1/res/exit.svg";
            ToolTip
            {
                id:eTip;
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
                    backgroundRect.returnSig();
                }
                onEntered:
                {
                    eTip.visible=true;
                }
                onExited:
                {
                    eTip.visible=false;
                }
            }
        }//退出按钮

        Text
        {
            anchors.top: parent.top;
            anchors.topMargin: 60;
            color: "white";
            font.pixelSize: 30;
            font.bold: true;
            text: qsTr("规则:sadddddddddd");
        }
    }

}
