#include "widget.h"

#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    a.setWindowIcon(QIcon(":/new/prefix1/res/PuzzlePiece.svg"));
    Widget w;
    w.show();
    return a.exec();
}
