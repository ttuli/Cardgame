#include "widget.h"
#include <QHBoxLayout>
#include <QQmlContext>
#include <QSettings>
#include <QFile>

Widget::Widget(QWidget *parent)
    : QWidget(parent)
{
    setFixedSize(600,900);
    setWindowFlags(Qt::WindowCloseButtonHint|Qt::WindowMinimizeButtonHint);

    GameSetting.append("0000001000000000");
    GameSetting.append("0000011000000000");
    GameSetting.append("0000111000000000");
    GameSetting.append("0000111100000000");
    GameSetting.append("0000111101000000");
    GameSetting.append("0000111110100000");
    GameSetting.append("0000111111100000");
    GameSetting.append("0000111111110000");
    GameSetting.append("0000111111111000");
    GameSetting.append("0000111111111101");
    GameSetting.append("0000111111111110");
    GameSetting.append("0000011010001100");
    GameSetting.append("0000111101001110");
    GameSetting.append("0000111110111100");
    GameSetting.append("0000111110111110");
    GameSetting.append("0000111111011111");
    GameSetting.append("0000011111111111");
    GameSetting.append("0000011011110110");
    GameSetting.append("0000011111011111");
    GameSetting.append("0000011111111111");

    qwid=new QQuickWidget(this);
    qwid->rootContext()->setContextProperty("totalNumber",GameSetting.size());
    qwid->setSource(QUrl("qrc:/MainInterface.qml"));
    qwid->setResizeMode(QQuickWidget::SizeRootObjectToView);
    rootobject=(QObject*)(qwid->rootObject());

    QHBoxLayout *qhb=new QHBoxLayout(this);
    qhb->setContentsMargins(0,0,0,0);
    qhb->addWidget(qwid);

    connect(rootobject,SIGNAL(cloSig()),this,SLOT(close()));
    connect(rootobject,SIGNAL(initGame(int)),this,SLOT(initGame(int)));
}

Widget::~Widget() {}


void Widget::initGame(int index)
{
    QMetaObject::invokeMethod(rootobject,"setGame",Q_ARG(QVariant,GameSetting[index]));
}
