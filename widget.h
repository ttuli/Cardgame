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

    QStringList GameSetting;

private:


private slots:
    void initGame(int index);
};
#endif // WIDGET_H
