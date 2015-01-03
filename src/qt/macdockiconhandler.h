#ifndef MACDOCKICONHANDLER_H
#define MACDOCKICONHANDLER_H

<<<<<<< HEAD
#include <QtCore/QObject>

class QMenu;
class QIcon;
class QWidget;
class objc_object;
=======
#include <QObject>
#include <QMainWindow>

QT_BEGIN_NAMESPACE
class QMenu;
class QIcon;
class QWidget;
QT_END_NAMESPACE

#ifdef __OBJC__
@class DockIconClickEventHandler;
#else
class DockIconClickEventHandler;
#endif
>>>>>>> origin/Paycoin-master

/** Macintosh-specific dock icon handler.
 */
class MacDockIconHandler : public QObject
{
    Q_OBJECT
<<<<<<< HEAD
=======

>>>>>>> origin/Paycoin-master
public:
    ~MacDockIconHandler();

    QMenu *dockMenu();
    void setIcon(const QIcon &icon);
<<<<<<< HEAD

=======
    void setMainWindow(QMainWindow *window);
>>>>>>> origin/Paycoin-master
    static MacDockIconHandler *instance();

    void handleDockIconClickEvent();

signals:
    void dockIconClicked();

<<<<<<< HEAD
public slots:

private:
    MacDockIconHandler();

    objc_object *m_dockIconClickEventHandler;
    QWidget *m_dummyWidget;
    QMenu *m_dockMenu;
=======
private:
    MacDockIconHandler();

    DockIconClickEventHandler *m_dockIconClickEventHandler;
    QWidget *m_dummyWidget;
    QMenu *m_dockMenu;
    QMainWindow *mainWindow;
>>>>>>> origin/Paycoin-master
};

#endif // MACDOCKICONCLICKHANDLER_H
