import QtQuick 2.15
import QtMultimedia

Rectangle
{
    anchors.fill: parent;
    color:"transparent";

    property int btnMargin: 20;
    property string fontInterval: "    ";
    property int btnWidth: 200;
    property int btnHeight: 80;
    property int arrowToButMargin: 50;

    property bool clobtnClicked: false;
    property bool ruleClicked: false;
    property bool startbtnClicked: false;

    signal sonCloSig();
    signal sonStartSig();
    signal sonRuleSig();

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


    Rectangle
    {
        id:btnArrow;
        color: "transparent";
        anchors.centerIn: startbtn;
        width: btnWidth+arrow1.width*2+arrowToButMargin;
        height: btnHeight;
        Image
        {
            id:arrow1;
            source: "/new/prefix1/res/divider-fade-000.png";
            anchors.verticalCenter: parent.verticalCenter;
            anchors.left: parent.left;
        }
        Image
        {
            id:arrow2;
            source: "/new/prefix1/res/divider-fade-000.png";
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right: parent.right;
            rotation: 180;
        }

        Behavior on width {
            NumberAnimation
            {
                duration: 80;
            }
        }

        onWidthChanged:
        {
            if(btnArrow.width===btnWidth+arrow1.width*2)
            {
                if(clobtnClicked)sonCloSig();
                if(startbtnClicked)sonStartSig();
                if(ruleClicked)sonRuleSig();
                clobtnClicked=false;
                startbtnClicked=false;
                ruleClicked=false;
                btnArrow.width=btnWidth+arrow1.width*2+arrowToButMargin;
            }
        }
    }

    Text
    {
        id:titleText;
        text: "翻翻乐";
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.top: parent.top;
        anchors.topMargin: 80;
        font.pixelSize: 100;
        color: "white";
        font.bold: true;
    }

    Text
    {
        anchors.top: titleText.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.topMargin: 50;
        text: "copyright:2024@zeng";
        font.pixelSize: 20;
        color: "white";
    }

    Image
    {
        id: startbtn;
        source: "/new/prefix1/res/textBackground.png";
        anchors.bottom: rule.top;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.bottomMargin: btnMargin;
        width: btnWidth;
        height: btnHeight;
        Text {
            anchors.centerIn: parent;
            text: "开"+fontInterval+"始";
            font.pixelSize: 30;
            font.bold: true;
            color: "white";

        }
        MouseArea
        {
            anchors.fill: parent;
            hoverEnabled: true;
            onEntered:
            {
                btnArrow.anchors.centerIn=startbtn;
                hoverVoice.stop();
                hoverVoice.play();
            }
            onClicked:
            {
                clickVoice.stop();
                clickVoice.play();
                btnArrow.width=btnWidth+arrow1.width*2;
                startbtnClicked=true;
            }
        }
    }//开始按钮

    Image
    {
        id: rule;
        source: "/new/prefix1/res/textBackground.png";
        anchors.top: parent.verticalCenter;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.topMargin: 120;
        width: btnWidth;
        height: btnHeight;
        Text {
            anchors.centerIn: parent;
            text: "规"+fontInterval+"则";
            font.pixelSize: 30;
            font.bold: true;
            color: "white";

        }
        MouseArea
        {
            anchors.fill: parent;
            hoverEnabled: true;
            onEntered:
            {
                btnArrow.anchors.centerIn=rule;
                hoverVoice.stop();
                hoverVoice.play();
            }
            onClicked:
            {
                clickVoice.stop();
                clickVoice.play();
                btnArrow.width=btnWidth+arrow1.width*2;
                ruleClicked=true;
            }
        }
    }//规则

    Image
    {
        id: exitbtn
        source: "/new/prefix1/res/textBackground.png";
        anchors.top: rule.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.topMargin: btnMargin;
        width: btnWidth;
        height: btnHeight;
        Text {
            anchors.centerIn: parent;
            text: "退"+fontInterval+"出";
            font.pixelSize: 30;
            font.bold: true;
            color: "white";
        }
        MouseArea
        {
            anchors.fill: parent;
            hoverEnabled: true;
            onEntered:
            {
                btnArrow.anchors.centerIn=exitbtn;
                hoverVoice.stop();
                hoverVoice.play();
            }
            onClicked:
            {
                clickVoice.stop();
                clickVoice.play();
                btnArrow.width=btnWidth+arrow1.width*2;
                clobtnClicked=true;
            }
        }
    }//退出按钮

}

