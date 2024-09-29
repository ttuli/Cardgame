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

    GameSetting.append("0000011001100000");
    GameSetting.append("1001000000001001");
    GameSetting.append("0101101001011010");
    GameSetting.append("1111000000001111");
    GameSetting.append("0010010110100100");
    GameSetting.append("1000010000100001");
    GameSetting.append("0110100110010110");
    GameSetting.append("1100110000110011");
    GameSetting.append("0001001001000001");
    GameSetting.append("1010010110100101");
    GameSetting.append("0100101001010010");
    GameSetting.append("1110011111011100");
    GameSetting.append("0011010110100011");
    GameSetting.append("1001001001001001");
    GameSetting.append("0110110101101101");
    GameSetting.append("1101101101101101");
    GameSetting.append("0010011111100100");
    GameSetting.append("1011011011011010");
    GameSetting.append("0101101001011011");
    GameSetting.append("1111100110011111");

    qwid=new QQuickWidget(this);
    qwid->rootContext()->setContextProperty("Widget",this);
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
