import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

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

    property string s:" ";
    property int currentlevel:0;

    signal cloSig();
    signal checkStateSig();
    signal resetSig();
    signal allOkSig();
    signal initGame(int pos);

    Timer
    {
        id:delayCheck;
        interval: 100;
        repeat: true;
        onTriggered:
        {
            checkStateSig();
        }
    }

    onCheckStateSig: function()
    {
        delayCheck.stop();
        for(var i=0;i<16;i++)
        {
            if(gridview.itemAtIndex(i).visible===true)
            {
                if(!(gridview.itemAtIndex(i).checkRotation()))
                {
                    return;
                }
            }
        }
        allOkSig();
    }

    Popup
    {
        id:successTip;
        anchors.centerIn: parent;
        width: 250;
        height: 200;
        visible: false;
        modal: true;
        closePolicy: "NoAutoClose";

        enter: Transition {
                    NumberAnimation
                    {
                        properties: "opacity";
                        from: 0;
                        to:1;
                        duration: 80;
                    }
                }
        exit: Transition {
            NumberAnimation
            {
                properties: "opacity";
                from: 1;
                to:0;
                duration: 80;
            }
        }
        background:Rectangle
        {
            color:"white";
            radius: 5;

            Text {
                id:successPass
                text: qsTr("通过!");
                font.bold: true;
                font.pixelSize: 30;
                anchors.horizontalCenter: parent.horizontalCenter;
                anchors.top: parent.top;
                anchors.topMargin: 10;
            }
            Rectangle
            {
                id:nextrec;
                anchors.left: parent.left;
                anchors.bottom: parent.bottom;
                anchors.bottomMargin: 20;
                anchors.leftMargin: 10;
                visible: if(currentlevel+2>totalNumber)
                             return false;
                else return true;
                color:"transparent";
                width: 100;
                height: 60;

                Image {
                    anchors.fill: parent;
                    source: "/new/prefix1/res/btn.png";
                }
                Text {
                    anchors.centerIn: parent;
                    text: qsTr("下一关");
                    font.pixelSize: 20;
                    font.bold: true;
                    color: "white";
                }
                MouseArea
                {
                    anchors.fill: parent;
                    hoverEnabled: true;
                    onEntered:
                    {
                        hoverVoice.stop();
                        hoverVoice.play();
                    }
                    onClicked:
                    {
                        clickVoice.stop();
                        clickVoice.play();
                        initGame(currentlevel+1);
                        currentlevel++;
                        successTip.close();
                    }
                }
            }
            Rectangle
            {
                id:returnMenu;
                anchors.right: parent.right;
                anchors.bottom: parent.bottom;
                anchors.bottomMargin: 20;
                anchors.rightMargin: 10;

                color:"transparent";
                width: 100;
                height: 60;

                Image {
                    anchors.fill: parent;
                    source: "/new/prefix1/res/btn.png";
                }
                Text {
                    anchors.centerIn: parent;
                    text: qsTr("返回");
                    font.pixelSize: 20;
                    font.bold: true;
                    color: "white";
                }
                MouseArea
                {
                    anchors.fill: parent;
                    hoverEnabled: true;
                    onEntered:
                    {
                        hoverVoice.stop();
                        hoverVoice.play();
                    }
                    onClicked:
                    {
                        clickVoice.stop();
                        clickVoice.play();
                        setVisible(false,false,false,true);
                        successTip.close();
                    }
                }
            }//返回
        }//background
    }//Popup

    onAllOkSig: function()
    {
        successVoice.play();
        successTip.open();
    }

    function setGame(a)
    {
        s=a;
        setVisible(false,false,true,false);
        for(var i=0;i<16;i++)
        {
            gridview.itemAtIndex(i).resetAll();
            gridview.itemAtIndex(i).visible=true;
        }

        for(var i=0;i<s.length;i++)
        {
            if(s[i]==="0")
            gridview.itemAtIndex(i).visible=false;
        }

    }

    function setVisible(vgameMenu,vruleInterface,vgaming,vlevelMenu)
    {
        gameMenu.visible=vgameMenu;
        ruleInterface.visible=vruleInterface;
        gaming.visible=vgaming;
        levelMenu.visible=vlevelMenu;
    }

    onResetSig: function()
    {
        pageturn.play();
        for(var i=0;i<16;i++)
        {
            if(gridview.itemAtIndex(i).visible===true)
            gridview.itemAtIndex(i).resetAll();
        }
    }

    SoundEffect
    {
        id:successVoice;
        source:"qrc:/new/prefix1/res/success.wav";
        volume: 0.2;
    }

    SoundEffect
    {
        id:pageturn;
        source: "qrc:/new/prefix1/res/pageturn-102978.wav";
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

    LevelMenu
    {
        id:levelMenu;
        anchors.fill: parent;
        visible: false;
        onSonReturnSig: function()
        {
            setVisible(true,false,false,false);
        }
        onSonChoiceSig:function(pos)
        {
            currentlevel=pos;
            initGame(pos);
        }
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
            setVisible(false,false,false,true);
        }
        onSonRuleSig:function()
        {
            setVisible(false,true,false,false);
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
            anchors.left: parent.left;
            anchors.margins: 10;
            width: 40;
            height: 40;
            source: "/new/prefix1/res/reset.svg";
            ToolTip
            {
                id:resetTip
                visible: false;
                text: "重置";
            }
            MouseArea
            {
                anchors.fill: parent;
                cursorShape: Qt.PointingHandCursor;
                hoverEnabled: true;
                onEntered:
                {
                    resetTip.visible=true;
                }
                onExited:
                {
                    resetTip.visible=false;
                }
                onClicked:
                {
                    resetSig();
                }
            }
        }

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
                    setVisible(true,false,false,false);
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

                property var dx:[-1,0,1,0];
                property var dy: [0,1,0,-1]
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
                    if((rotate.angle/180)%2===0)
                        return false;
                    else return true;
                }

                function resetAll()
                {
                    if(rotate.angle/180%2!==0)
                        rotate.angle+=180;
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
                            if(!pageturn.playing)pageturn.play();
                            for(var i=0;i<4;i++)
                            {
                                var a=Math.floor(index/4)+dx[i];
                                var b=index%4+dy[i];
                                if(0<=a&&b>=0&&a<4&&b<4)
                                {
                                    gridview.itemAtIndex(a*4+b).setRotation();
                                }
                            }
                            delayCheck.start();
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
                    setVisible(true,false,false,false);
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
            anchors.fill: parent;
            wrapMode: Text.WordWrap;
            anchors.topMargin: 60;
            anchors.rightMargin: 10;
            anchors.leftMargin: 10;
            color: "white";
            font.pixelSize: 30;
            font.bold: true;
            text: qsTr("规则:\n初始每个牌都为背面，点击可以翻转该牌，同时其上下左右(若存在)都变为自身相反的状态，当所有牌都为正面时通过");
        }
    }

}
