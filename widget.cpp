#include "widget.h"
#include <QHBoxLayout>
#include <QQmlContext>

Widget::Widget(QWidget *parent)
    : QWidget(parent)
{
    setFixedSize(600,900);
    setWindowFlags(Qt::WindowCloseButtonHint|Qt::WindowMinimizeButtonHint);

    qwid=new QQuickWidget(this);
    qwid->rootContext()->setContextProperty("Widget",this);
    qwid->setSource(QUrl("qrc:/MainInterface.qml"));
    qwid->setResizeMode(QQuickWidget::SizeRootObjectToView);
    rootobject=(QObject*)(qwid->rootObject());

    QHBoxLayout *qhb=new QHBoxLayout(this);
    qhb->setContentsMargins(0,0,0,0);
    qhb->addWidget(qwid);

    connect(rootobject,SIGNAL(cloSig()),this,SLOT(close()));
}

Widget::~Widget() {}
