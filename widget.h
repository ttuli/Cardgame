#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include <QQuickWidget>

class Widget : public QWidget
{
    Q_OBJECT

public:
    Widget(QWidget *parent = nullptr);
    ~Widget();

private:
    QQuickWidget *qwid;

    QObject *rootobject;

};
#endif // WIDGET_H
