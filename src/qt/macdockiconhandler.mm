<<<<<<< HEAD

#include "macdockiconhandler.h"

#include <QtGui/QMenu>
#include <QtGui/QWidget>

extern void qt_mac_set_dock_menu(QMenu*);
=======
#include "macdockiconhandler.h"

#include <QMenu>
#include <QWidget>
#include <QTemporaryFile>
#include <QImageWriter>
>>>>>>> origin/Paycoin-master

#undef slots
#include <Cocoa/Cocoa.h>

<<<<<<< HEAD
=======
#if QT_VERSION < 0x050000
extern void qt_mac_set_dock_menu(QMenu *);
#endif

>>>>>>> origin/Paycoin-master
@interface DockIconClickEventHandler : NSObject
{
    MacDockIconHandler* dockIconHandler;
}

@end

@implementation DockIconClickEventHandler

- (id)initWithDockIconHandler:(MacDockIconHandler *)aDockIconHandler
{
    self = [super init];
    if (self) {
        dockIconHandler = aDockIconHandler;

        [[NSAppleEventManager sharedAppleEventManager]
            setEventHandler:self
                andSelector:@selector(handleDockClickEvent:withReplyEvent:)
              forEventClass:kCoreEventClass
                 andEventID:kAEReopenApplication];
    }
    return self;
}

- (void)handleDockClickEvent:(NSAppleEventDescriptor*)event withReplyEvent:(NSAppleEventDescriptor*)replyEvent
{
    Q_UNUSED(event)
    Q_UNUSED(replyEvent)

<<<<<<< HEAD
    if (dockIconHandler)
        dockIconHandler->handleDockIconClickEvent();
=======
    if (dockIconHandler) {
        dockIconHandler->handleDockIconClickEvent();
    }
>>>>>>> origin/Paycoin-master
}

@end

MacDockIconHandler::MacDockIconHandler() : QObject()
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
<<<<<<< HEAD
    this->m_dockIconClickEventHandler = [[DockIconClickEventHandler alloc] initWithDockIconHandler:this];

    this->m_dummyWidget = new QWidget();
    this->m_dockMenu = new QMenu(this->m_dummyWidget);
    qt_mac_set_dock_menu(this->m_dockMenu);
    [pool release];
}

=======

    this->m_dockIconClickEventHandler = [[DockIconClickEventHandler alloc] initWithDockIconHandler:this];
    this->m_dummyWidget = new QWidget();
    this->m_dockMenu = new QMenu(this->m_dummyWidget);
    this->setMainWindow(NULL);
#if QT_VERSION < 0x050000
    qt_mac_set_dock_menu(this->m_dockMenu);
#endif
    [pool release];
}

void MacDockIconHandler::setMainWindow(QMainWindow *window) {
    this->mainWindow = window;
}

>>>>>>> origin/Paycoin-master
MacDockIconHandler::~MacDockIconHandler()
{
    [this->m_dockIconClickEventHandler release];
    delete this->m_dummyWidget;
<<<<<<< HEAD
=======
    this->setMainWindow(NULL);
>>>>>>> origin/Paycoin-master
}

QMenu *MacDockIconHandler::dockMenu()
{
    return this->m_dockMenu;
}

void MacDockIconHandler::setIcon(const QIcon &icon)
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
<<<<<<< HEAD
    NSImage *image;
    if (icon.isNull())
        image = [[NSImage imageNamed:@"NSApplicationIcon"] retain];
    else {
        QSize size = icon.actualSize(QSize(128, 128));
        QPixmap pixmap = icon.pixmap(size);
        CGImageRef cgImage = pixmap.toMacCGImageRef();
        image = [[NSImage alloc] initWithCGImage:cgImage size:NSZeroSize];
        CFRelease(cgImage);
=======
    NSImage *image = nil;
    if (icon.isNull())
        image = [[NSImage imageNamed:@"NSApplicationIcon"] retain];
    else {
        // generate NSImage from QIcon and use this as dock icon.
        QSize size = icon.actualSize(QSize(128, 128));
        QPixmap pixmap = icon.pixmap(size);

        // write temp file hack (could also be done through QIODevice [memory])
        QTemporaryFile notificationIconFile;
        if (!pixmap.isNull() && notificationIconFile.open()) {
            QImageWriter writer(&notificationIconFile, "PNG");
            if (writer.write(pixmap.toImage())) {
                const char *cString = notificationIconFile.fileName().toUtf8().data();
                NSString *macString = [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
                image =  [[NSImage alloc] initWithContentsOfFile:macString];
            }
        }

        if(!image) {
            // if testnet image could not be created, load std. app icon
            image = [[NSImage imageNamed:@"NSApplicationIcon"] retain];
        }
>>>>>>> origin/Paycoin-master
    }

    [NSApp setApplicationIconImage:image];
    [image release];
    [pool release];
}

MacDockIconHandler *MacDockIconHandler::instance()
{
    static MacDockIconHandler *s_instance = NULL;
    if (!s_instance)
        s_instance = new MacDockIconHandler();
    return s_instance;
}

void MacDockIconHandler::handleDockIconClickEvent()
{
<<<<<<< HEAD
=======
    if (this->mainWindow)
    {
        this->mainWindow->activateWindow();
        this->mainWindow->show();
    }

>>>>>>> origin/Paycoin-master
    emit this->dockIconClicked();
}
