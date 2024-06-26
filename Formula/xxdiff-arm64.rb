class XxdiffArm64 < Formula
  desc "xxdiff is a graphical file and directories comparator and merge tool."
  homepage "https://furius.ca/xxdiff/"
  url "https://downloads.sourceforge.net/project/xxdiff/xxdiff/4.0.1/xxdiff-4.0.1.tar.bz2"
  sha256 "bf58ddda9d7a887f4f5cae20070ed5f2e0d65f575af20860738c6e2742c3a000"
  license "BSD-2-Clause"
  revision 3

  conflicts_with "xxdiff-x86_64", because: "you need to select either xxdiff-x86_64 or xxdiff-arm64, not both"
  depends_on arch: :arm64
  depends_on "bison" => :build
  depends_on "flex" => :build
  depends_on "qt@5"

  # https://github.com/macports/macports-ports/blob/master/devel/xxdiff/files/patch-qt5.diff
  # add upstream support for Qt 5
  # https://github.com/macports/macports-ports/blob/master/devel/xxdiff/files/patch-xxdiff.pro.diff
  # MacPorts uses newser bison; respect MacPorts compiler flags
  # https://github.com/macports/macports-ports/blob/master/devel/xxdiff/files/patch-no_hack.diff
  # macOS hack no longer seems to work
  #     see ports/macosx/README.macosx
  patch :p0, :DATA

  def install
    Dir.chdir("src") do
        system "make", "-f", "Makefile.bootstrap"
        system "make"
    end
    bin.install "bin/xxdiff.app/Contents/MacOS/xxdiff"
    man1.install "src/xxdiff.1"
  end
end
__END__
diff -urb ./CHANGES ./CHANGES
--- ./CHANGES	2016-05-15 15:55:57.000000000 -0700
+++ ./CHANGES	2019-06-26 09:20:52.000000000 -0700
@@ -5,6 +5,19 @@
 Current Development Version
 ---------------------------
 
+* Applied patch from Vadim Zhukov <persgray at gmail dot com> for more general
+  local encoding conversion.
+
+* Fixed coredump on long lines by allowing line length up to 2^32.
+  (Thanks to Jim Diamond for finding the issue.)
+
+Version 5.0b1: Port to Qt5 by Rene J.V. Bertin
+----------------------------------------------
+
+* Switch to Qt5 (tested with 5.6, probably ok with older versions too)
+* Add keyboard shortcuts for "Save as left" and "Save as right"
+* Prevent accidental wheel-zoom when pressing the Ctrl key while inertial scroll events are coming in.
+
 Version 4.0.1: Port to Qt4 by Alexandre Feblot
 ----------------------------------------------
 
diff -urb ./README ./README
--- ./README	2016-05-15 15:55:57.000000000 -0700
+++ ./README	2019-06-26 09:20:52.000000000 -0700
@@ -206,7 +206,7 @@
 Reporting Bugs
 ==============
 
-* `Reporting Bugs <http://sourceforge.net/tracker/?group_id=2198>`_
+* `Reporting Bugs <https://sourceforge.net/p/xxdiff/bugs/>`_
   *(bugs and feature requests)*
 
 **PLEASE!** report bugs using the bug tracker instead of email. It is extremely
diff -urb ./VERSION ./VERSION
--- ./VERSION	2016-05-15 15:55:57.000000000 -0700
+++ ./VERSION	2019-06-26 09:20:52.000000000 -0700
@@ -1 +1 @@
-4.0.1
+4.0.1
diff -urb ./doc/xxdiff-integration.html ./doc/xxdiff-integration.html
--- ./doc/xxdiff-integration.html	2016-05-15 15:55:57.000000000 -0700
+++ ./doc/xxdiff-integration.html	2019-06-26 09:20:52.000000000 -0700
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
-<meta name="generator" content="Docutils 0.11: http://docutils.sourceforge.net/" />
+<meta name="generator" content="Docutils 0.12: http://docutils.sourceforge.net/" />
 <title>Integrating xxdiff with scripts</title>
 <meta name="author" content="Martin Blais &lt;blais&#64;furius.ca&gt;" />
 <meta name="date" content="2004-01-21" />
@@ -13,7 +13,7 @@
 
 <div id="project-header">
   <a href="http://furius.ca/"><img src="http://furius.ca/home/furius-logo-w.png" id="logo"></a>
-  <div id="project-home"><a href="http://furius.ca/xxdiff">Project Home</a></div>
+  <div id="project-home"><a href="..">Project Home</a></div>
 </div>
 
 <div class="document" id="integrating-xxdiff-with-scripts">
diff -urb ./doc/xxdiff-secrets.html ./doc/xxdiff-secrets.html
--- ./doc/xxdiff-secrets.html	2016-05-15 15:55:57.000000000 -0700
+++ ./doc/xxdiff-secrets.html	2019-06-26 09:20:52.000000000 -0700
@@ -3,7 +3,7 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
-<meta name="generator" content="Docutils 0.11: http://docutils.sourceforge.net/" />
+<meta name="generator" content="Docutils 0.12: http://docutils.sourceforge.net/" />
 <title>The Almost Secret Features of xxdiff</title>
 <meta name="author" content="Martin Blais &lt;blais&#64;furius.ca&gt;" />
 <link rel="stylesheet" href="../style.css" type="text/css" />
@@ -12,7 +12,7 @@
 
 <div id="project-header">
   <a href="http://furius.ca/"><img src="http://furius.ca/home/furius-logo-w.png" id="logo"></a>
-  <div id="project-home"><a href="http://furius.ca/xxdiff">Project Home</a></div>
+  <div id="project-home"><a href="..">Project Home</a></div>
 </div>
 
 <div class="document" id="the-almost-secret-features-of-xxdiff">
diff -urb ./index.html ./index.html
--- ./index.html	2016-05-15 15:55:57.000000000 -0700
+++ ./index.html	2019-06-26 09:20:52.000000000 -0700
@@ -3,14 +3,14 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
-<meta name="generator" content="Docutils 0.10: http://docutils.sourceforge.net/" />
+<meta name="generator" content="Docutils 0.12: http://docutils.sourceforge.net/" />
 <title>xxdiff: Graphical File And Directories Comparator And Merge Tool</title>
 <link rel="stylesheet" href="style.css" type="text/css" />
 </head>
 <body>
 
 <div id="project-header">
-  <a href="/"><img src="/home/furius-logo-w.png" id="logo"></a>
+  <a href="http://furius.ca/"><img src="http://furius.ca/home/furius-logo-w.png" id="logo"></a>
   
 </div>
 
@@ -223,7 +223,7 @@
 <div class="section" id="reporting-bugs">
 <h1><a class="toc-backref" href="#id12">Reporting Bugs</a></h1>
 <ul class="simple">
-<li><a class="reference external" href="http://sourceforge.net/tracker/?group_id=2198">Reporting Bugs</a>
+<li><a class="reference external" href="https://sourceforge.net/p/xxdiff/bugs/">Reporting Bugs</a>
 <em>(bugs and feature requests)</em></li>
 </ul>
 <p><strong>PLEASE!</strong> report bugs using the bug tracker instead of email. It is extremely
diff -urb ./src/Makefile.bootstrap ./src/Makefile.bootstrap
--- ./src/Makefile.bootstrap	2016-05-15 15:55:57.000000000 -0700
+++ ./src/Makefile.bootstrap	2019-06-26 09:20:52.000000000 -0700
@@ -5,19 +5,22 @@
 #
 
 # Rule to generate the qmake Makefile for building xxdiff.
-QMAKE ?= /usr/bin/qmake
+QMAKE ?= qmake
+MAKEDIR ?= .
+QMAKEOPTS =
 
 all: Makefile
 
 OS := $(shell uname -s)
 ifeq ($(OS),Darwin)
     # Default is an Xcode project, so force a makefile build
-    export QMAKESPEC=macx-g++
+    export QMAKESPEC=macx-clang
 endif
 
-Makefile.qmake: xxdiff.pro
-	$(QMAKE) -o Makefile.qmake $<
+Makefile.qmake: $(MAKEDIR)/xxdiff.pro
+	$(QMAKE) $(QMAKEOPTS) -o Makefile.qmake $<
 
-Makefile: Makefile.qmake Makefile.extra
-	cat $^ > Makefile
+Makefile: Makefile.qmake $(MAKEDIR)/Makefile.extra
+	echo "MAKEDIR = $(MAKEDIR)" > Makefile
+	cat $^ >> Makefile
 
diff -urb ./src/Makefile.extra ./src/Makefile.extra
--- ./src/Makefile.extra	2016-05-15 15:55:57.000000000 -0700
+++ ./src/Makefile.extra	2019-06-26 09:20:52.000000000 -0700
@@ -4,7 +4,7 @@
 #
 
 # Extra targets.
-EXTRA_FILES = version.h doc.h
+EXTRA_FILES = version.h $(MAKEDIR)/doc.h
 
 .SUFFIXES: .html .txt .h
 
@@ -23,8 +23,8 @@
 #
 
 # Automatically generate a simple include file with version number in it.
-version.h: ../VERSION
-	echo "#define XX_VERSION \"`cat ../VERSION`\"" > $@
+version.h: $(MAKEDIR)/../VERSION
+	echo "#define XX_VERSION \"`cat $(MAKEDIR)/../VERSION`\"" > $@
 
 # Dependencies for the generated version file.
 proginfo.o: version.h
@@ -41,8 +41,8 @@
 	sed -e 's/\"/\\\"/g;s/$$/\\n\\/;1s/^/char text[]=\"/;$$s/\\$$/\"\;/' $< > $@
 
 # Dependencies for the generated documentation file.
-help.o: doc.h
-help.obj: doc.h
+help.o: $(MAKEDIR)/doc.h
+help.obj: $(MAKEDIR)/doc.h
 
 # Convert the reStructuredText documentation to html.  (this is only used by the
 # author, directly, manually, not that important for xxdiff packagers.)
@@ -60,13 +60,9 @@
 	rm -f $(EXTRA_FILES)
 
 
-# Override the qmake we use because the one in the path might be different.
-QMAKE = qmake
-
-
 # Note: we would need to add this to be correct.  Danger!  If the Makefile gets
 # remade, this file does not get appended again to the new makefile!
 all: Makefile
 
-Makefile: xxdiff.pro
-	$(MAKE) -f Makefile.bootstrap Makefile
+Makefile: $(MAKEDIR)/xxdiff.pro
+	$(MAKE) -f $(MAKEDIR)/Makefile.bootstrap Makefile
diff -urb ./src/accelUtil.cpp ./src/accelUtil.cpp
--- ./src/accelUtil.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/accelUtil.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -27,7 +27,7 @@
 #include <accelUtil.h>
 #include <resources.h>
 
-#include <QtGui/QKeySequence>
+#include <QKeySequence>
 
 #include <iostream>
 #include <string.h>
@@ -49,7 +49,7 @@
    QString cval = val.trimmed().toLower();
 
    QKeySequence keyseq = QKeySequence::fromString( cval );
-   accel = (int)keyseq;
+   accel = keyseq[0];
    
    // Check that converting back gets the original value
    return ( cval == keyseq.toString().toLower() );
@@ -59,7 +59,7 @@
 //
 void XxAccelUtil::write( std::ostream& os, int accel )
 {
-   os << QKeySequence( accel ).toString().toAscii().constData();
+   os << QKeySequence( accel ).toString().toLocal8Bit().constData();
 }
 
 XX_NAMESPACE_END
diff -urb ./src/accelUtil.h ./src/accelUtil.h
--- ./src/accelUtil.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/accelUtil.h	2019-06-26 09:20:52.000000000 -0700
@@ -32,7 +32,7 @@
 #endif
 
 #ifndef INCL_QT_QSTRING
-#include <QtCore/QString>
+#include <QString>
 #define INCL_QT_QSTRING
 #endif
 
diff -urb ./src/app.cpp ./src/app.cpp
--- ./src/app.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/app.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -49,31 +49,31 @@
 #include <central.h>
 #include <borderLabel.h>
 
-#include <QtGui/QMainWindow>
-#include <QtGui/QMenu>
-#include <QtGui/QMenuBar>
-#include <QtGui/QLayout>
-#include <QtGui/QScrollBar>
-#include <QtGui/QLabel>
-#include <QtGui/QStyleFactory>
-#include <QtGui/QFont>
-#include <QtGui/QMessageBox>
-#include <QtGui/QFileDialog>
-#include <QtGui/QShortcut>
-#include <QtGui/QWhatsThis>
-#include <QtGui/QClipboard>
-#include <QtCore/QProcess>
-#include <QtGui/QToolBar>
-#include <QtGui/QAction>
-#include <QtCore/QTextStream>
-#include <QtCore/QFile>
-#include <QtGui/QSplitter>
-#include <QtCore/QRegExp>
-#include <QtGui/QCheckBox>
-#include <QtCore/QDateTime>
-#include <QtGui/QPixmap>
-#include <QtGui/QHBoxLayout>
-#include <QtGui/QVBoxLayout>
+#include <QMainWindow>
+#include <QMenu>
+#include <QMenuBar>
+#include <QLayout>
+#include <QScrollBar>
+#include <QLabel>
+#include <QStyleFactory>
+#include <QFont>
+#include <QMessageBox>
+#include <QFileDialog>
+#include <QShortcut>
+#include <QWhatsThis>
+#include <QClipboard>
+#include <QProcess>
+#include <QToolBar>
+#include <QAction>
+#include <QTextStream>
+#include <QFile>
+#include <QSplitter>
+#include <QRegExp>
+#include <QCheckBox>
+#include <QDateTime>
+#include <QPixmap>
+#include <QHBoxLayout>
+#include <QVBoxLayout>
 
 
 #ifdef XX_KDE
@@ -179,7 +179,7 @@
    XxMainWindow(
       XxApp*      app,
       QWidget*    parent = 0,
-      Qt::WFlags      f = Qt::Window
+      Qt::WindowFlags      f = Qt::Window
    );
 
 
@@ -197,11 +197,13 @@
 XxMainWindow::XxMainWindow(
    XxApp*      app,
    QWidget*    parent,
-   Qt::WFlags      f
+   Qt::WindowFlags      f
 ) :
    QkMainWindow( parent, f ),
    _app( app )
-{}
+{
+   (void)_app; // suppress "unused" warning
+}
 
 }
 
@@ -243,14 +245,14 @@
    // Read in the resources and create resources object.
    _resources = buildResources();
 
-// We do not force the style anymore.
-// #ifndef XX_KDE
-//    // By default, if not specified, force SGI style.
-//    if ( !_cmdline._forceStyle ) {
-//       _style = QStyleFactory::create( _resources->getStyleKey() );
-//       setStyle( _style );
-//    }
-// #endif
+#ifndef XX_KDE
+   if ( !_cmdline._forceStyle ) {
+      _style = QStyleFactory::create( _resources->getStyleKey() );
+      if (_style) {
+         setStyle( _style );
+      }
+   }
+#endif
 
 #ifndef XX_KDE
    if ( _cmdline._forceFont == false ) {
@@ -2283,12 +2285,12 @@
          if ( _resources->getBoolOpt( BOOL_DIRDIFF_RECURSIVE ) ) {
             dirdiff_command = _resources->getCommand(
                CMD_DIFF_DIRECTORIES_REC
-            ).toAscii();
+            ).toLocal8Bit();
          }
          else {
             dirdiff_command = _resources->getCommand(
                CMD_DIFF_DIRECTORIES
-            ).toAscii();
+            ).toLocal8Bit();
          }
          std::auto_ptr<XxDiffs> tmp(
             dirsBuilder->process( dirdiff_command.constData(), *_files[0], *_files[1] )
@@ -3522,7 +3524,7 @@
              QString * tmpTitle = new QString();
              tmpTitle->sprintf( "--title%d=%s",
                                 ii+1,
-                                _cmdline._userFilenames[ii].toLatin1().constData() );
+                                _cmdline._userFilenames[ii].toLocal8Bit().constData() );
              titles[ii] = tmpTitle;
          }
       }
@@ -3547,7 +3549,7 @@
 
    if ( filenames.count() > 0 ) {
       // Spawn a diff.
-      QString command = argv()[0];
+      QString command = arguments()[0];
 
       if ( filenames.count() == 1 ) {
          command += QString(" --single ");
diff -urb ./src/app.h ./src/app.h
--- ./src/app.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/app.h	2019-06-26 09:20:52.000000000 -0700
@@ -48,12 +48,12 @@
 #endif
 
 #ifndef INCL_QT_QAPPLICATION
-#include <QtGui/QApplication>
+#include <QApplication>
 #define INCL_QT_QAPPLICATION
 #endif
 
 #ifndef INCL_QT_QFILEINFO
-#include <QtCore/QFileInfo>
+#include <QFileInfo>
 #define INCL_QT_QFILEINFO
 #endif
 
diff -urb ./src/app.inline.h ./src/app.inline.h
--- ./src/app.inline.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/app.inline.h	2019-06-26 09:20:52.000000000 -0700
@@ -37,7 +37,7 @@
 #endif
 
 #ifndef INCL_QT_QSCROLLBAR
-#include <QtGui/QScrollBar>
+#include <QScrollBar>
 #define INCL_QT_QSCROLLBAR
 #endif
 
diff -urb ./src/borderLabel.cpp ./src/borderLabel.cpp
--- ./src/borderLabel.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/borderLabel.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -27,13 +27,13 @@
 #include <borderLabel.h>
 #include <app.h>
 
-#include <QtGui/QPainter>
-#include <QtGui/QBrush>
-#include <QtGui/QPen>
-#include <QtGui/QColor>
+#include <QPainter>
+#include <QBrush>
+#include <QPen>
+#include <QColor>
 
-#include <QtGui/QApplication>
-#include <QtGui/QLabel>
+#include <QApplication>
+#include <QLabel>
 
 #include <stdio.h>
 
diff -urb ./src/borderLabel.h ./src/borderLabel.h
--- ./src/borderLabel.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/borderLabel.h	2019-06-26 09:20:52.000000000 -0700
@@ -36,7 +36,7 @@
 #endif
 
 #ifndef INCL_QT_QLABEL
-#include <QtGui/QLabel>
+#include <QLabel>
 #define INCL_QT_QLABEL
 #endif
 
diff -urb ./src/buffer.cpp ./src/buffer.cpp
--- ./src/buffer.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/buffer.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -28,10 +28,10 @@
 #include <exceptions.h>
 #include <util.h>
 
-#include <QtGui/QFontMetrics>
-#include <QtGui/QFont>
-#include <QtCore/QRect>
-#include <QtCore/QDir>
+#include <QFontMetrics>
+#include <QFont>
+#include <QRect>
+#include <QDir>
 
 #include <iostream>
 #include <string.h>
@@ -52,20 +52,6 @@
 
 //------------------------------------------------------------------------------
 //
-const char* strnchr( const char* s, int c, const char* end ) 
-{
-   const char* pc = s;
-   while ( pc < end ) {
-      if ( *pc == c ) {
-         return pc;
-      }
-      pc++;
-   }
-   return 0;
-}
-
-//------------------------------------------------------------------------------
-//
 const char* strnstr( const char* haystack, const uint n, const char* needle ) 
 {
    const char* p = haystack;
@@ -213,7 +199,7 @@
    }
 
    if ( _deleteFile == true ) {
-      XxUtil::removeFile( _name.toLatin1().constData() );
+      XxUtil::removeFile( _name.toLocal8Bit().constData() );
    }
 }
 
@@ -282,7 +268,7 @@
 void XxBuffer::loadFile( const QFileInfo& finfo )
 {
    // Read file into buffer.
-   FILE* fp = fopen( _name.toLatin1().constData(), "r" );
+   FILE* fp = fopen( _name.toLocal8Bit().constData(), "r" );
    if ( fp == 0 ) {
       throw XxIoError( XX_EXC_PARAMS );
    }
@@ -377,7 +363,7 @@
          it != _directoryEntries.end();
          ++it ) {
       int len = (*it).length();
-      ::strncpy( bufferPtr, (*it).toLatin1().constData(), len );
+      ::strncpy( bufferPtr, (*it).toLocal8Bit().constData(), len );
       bufferPtr[len] = _newlineChar;
       bufferPtr += len + 1;
    }
@@ -433,7 +419,7 @@
          _index.push_back( ii + 1 );
 #ifdef XX_ENABLED_BUFFER_LINE_LENGTHS
          _lengths.push_back( ii - prev );
-         prev = static_cast<short>( ii + 1 );
+         prev = static_cast<unsigned int>( ii + 1 );
 #endif
       }
    }
@@ -457,7 +443,7 @@
    std::swap( _index, oldIndex );
 
 #ifdef XX_ENABLED_BUFFER_LINE_LENGTHS
-   std::vector<short> oldLengths;
+   std::vector<unsigned int> oldLengths;
    std::swap( _lengths, oldLengths );
 #endif
 
@@ -710,7 +696,7 @@
    const QString& format
 )
 {
-   _lnBuffer.sprintf( format.toLatin1().constData(), lineNumber );
+   _lnBuffer.sprintf( format.toLocal8Bit().constData(), lineNumber );
    return _lnBuffer;
 }
 
@@ -721,7 +707,7 @@
    bool found = false;
    uint len;
    const char* text = getTextLine( lineno, len );
-   if ( strnstr( text, len, searchText.toLatin1().constData() ) != 0 ) {
+   if ( strnstr( text, len, searchText.toLocal8Bit().constData() ) != 0 ) {
       found = true;
    }
    return found;
diff -urb ./src/buffer.h ./src/buffer.h
--- ./src/buffer.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/buffer.h	2019-06-26 09:20:52.000000000 -0700
@@ -51,17 +51,17 @@
 #endif
 
 #ifndef INCL_QT_QSTRING
-#include <QtCore/QString>
+#include <QString>
 #define INCL_QT_QSTRING
 #endif
 
 #ifndef INCL_QT_QSTRINGLIST
-#include <QtCore/QStringList>
+#include <QStringList>
 #define INCL_QT_QSTRINGLIST
 #endif
 
 #ifndef INCL_QT_QFILEINFO
-#include <QtCore/QFileInfo>
+#include <QFileInfo>
 #define INCL_QT_QFILEINFO
 #endif
 
@@ -268,16 +268,11 @@
 
 #define XX_ENABLED_BUFFER_LINE_LENGTHS
 #ifdef XX_ENABLED_BUFFER_LINE_LENGTHS
-   // Important note: due to the use of the short datatype to record line
-   // lengths, xxdiff is limited to lines of length up to 64k characters. We
-   // consider this reasonable for all purposes. However, this could be easily
-   // changed to int below if necessary.
-   //
    // We had to introduce an explicit vector of lengths because since the
    // unmerge feature was introduced, we're sharing the very text buffer that
    // the multiple buffers use we cannot anymore rely on buffer lines appearing
    // next to each other in the data array.
-   std::vector<short> _lengths;
+   std::vector<unsigned int> _lengths;
 #endif
 
    // Indirection index for reindexed files. This array contains the line
diff -urb ./src/builderDirs2.cpp ./src/builderDirs2.cpp
--- ./src/builderDirs2.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/builderDirs2.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -30,12 +30,12 @@
 #include <util.h>
 #include <buffer.h>
 
-#include <QtCore/QString>
-#include <QtCore/QByteArray>
-#include <QtCore/QStringList>
-#include <QtCore/QTextStream>
-#include <QtCore/QFile>
-#include <QtCore/QProcess>
+#include <QString>
+#include <QByteArray>
+#include <QStringList>
+#include <QTextStream>
+#include <QFile>
+#include <QProcess>
 
 #include <stdexcept>
 #include <stdio.h>
@@ -130,17 +130,20 @@
 bool parseDiffLine( 
    const QString& line,
    const QString& dir1,
-   int            len1,
    const QString& dir2,
-   int            len2,
    DirDiffType&   type,
    QString&       filename,
    int&           onlyDir
 )
 {
-   QByteArray lineBa = line.toLatin1();
+   QByteArray lineBa = line.toLocal8Bit();
    const char* buf = lineBa.constData();
 
+   QByteArray bytes1 = dir1.toLocal8Bit();
+   QByteArray bytes2 = dir2.toLocal8Bit();
+   const int len1 = bytes1.size();
+   const int len2 = bytes2.size();
+
    bool error;
    const char* bufPtr = buf;
    onlyDir = -1; /* don't take chances with chance */
@@ -152,8 +155,8 @@
       }
       
       //int len = colonPtr - bufPtr;
-      int cmp1 = ::strncmp( bufPtr, dir1.toLatin1().constData(), len1 );
-      int cmp2 = ::strncmp( bufPtr, dir2.toLatin1().constData(), len2 );
+      int cmp1 = ::strncmp( bufPtr, bytes1.constData(), len1 );
+      int cmp2 = ::strncmp( bufPtr, bytes2.constData(), len2 );
       // Note: you cannot compare the lengths because these might be directory
       // diffs.
       if ( cmp1 == 0 && cmp2 == 0 ) {
@@ -179,7 +182,7 @@
          ++dnamePtr;
       }
       if ( colonPtr - dnamePtr > 0 ) {
-         QString aname( QString::fromLatin1( dnamePtr, colonPtr - dnamePtr ) );
+         QString aname( QString::fromLocal8Bit( dnamePtr, colonPtr - dnamePtr ) );
          filename += aname;
          if ( filename.at( filename.length() - 1 ) != '/' ) {
             filename.append( '/' );
@@ -187,7 +190,7 @@
       }
 
       // Note: need to remove \n
-       QString bname( QString::fromLatin1( colonPtr + 2 ) );
+       QString bname( QString::fromLocal8Bit( colonPtr + 2 ) );
 
       filename += bname;
       type = ONLY_IN;
@@ -205,7 +208,7 @@
       }
       int mlen = andPtr - filenamePtr;
       if ( mlen > 0 ) {
-         filename = QString::fromLatin1( filenamePtr, mlen );
+         filename = QString::fromLocal8Bit( filenamePtr, mlen );
       }
       else {
          filename = QString();
@@ -236,7 +239,7 @@
       }
       int mlen = andPtr - filenamePtr;
       if ( mlen > 0 ) {
-         filename = QString::fromLatin1( filenamePtr, mlen );
+         filename = QString::fromLocal8Bit( filenamePtr, mlen );
       }
       else {
          filename = QString();
@@ -267,7 +270,7 @@
       for ( unsigned int ii = 0; ii < entries.count(); ++ii ) {
          XX_TRACE( entries[ii] );
       }
-      XX_TRACE( "filename \"" << filename.toLatin1().constData() << "\"" );
+      XX_TRACE( "filename \"" << filename.toLocal8Bit().constData() << "\"" );
 #endif
       throw XxInternalError( XX_EXC_PARAMS );
    }
@@ -320,8 +323,6 @@
 
    QString path1 = buffer1.getName();
    QString path2 = buffer2.getName();
-   const int len1 = path1.length();
-   const int len2 = path2.length();
 
    while ( true ) {
       if ( ! diffProc.canReadLine() ) {
@@ -335,7 +336,7 @@
       QString filename;
       int onlyDir = -1;
       if ( parseDiffLine(
-         line, path1, len1, path2, len2, type, filename, onlyDir
+         line, path1, path2, type, filename, onlyDir
       ) == true ) {
          XX_LOCAL_TRACE( "ERROR" );
          errors << "Diff error:" << endl;
@@ -346,7 +347,7 @@
 #ifdef LOCAL_TRACE
       XX_TRACE( line 
                 << typeString[ type ] << "   " 
-                << filename.toLatin1().constData() << "   "
+                << filename.toLocal8Bit().constData() << "   "
                 << onlyDir );
       if ( type == UNKNOWN ) {
          throw XxInternalError( XX_EXC_PARAMS );
@@ -402,11 +403,11 @@
    {
       for ( QStringList::ConstIterator iter = entries1.begin();
             iter != entries1.end(); ++iter ) {
-         XX_TRACE( (*iter).toLatin1().constData() );
+         XX_TRACE( (*iter).toLocal8Bit().constData() );
       }
       for ( QStringList::ConstIterator iter = entries2.begin();
             iter != entries2.end(); ++iter ) {
-         XX_TRACE( (*iter).toLatin1().constData() );
+         XX_TRACE( (*iter).toLocal8Bit().constData() );
       }
    }
 #endif
@@ -419,9 +420,6 @@
    QString path1 = buffer1.getName();
    QString path2 = buffer2.getName();
 
-   const int len1 = path1.length();
-   const int len2 = path2.length();
-
    while ( true ) {
       if ( ! diffProc.canReadLine() ) {
          if ( ! diffProc.waitForReadyRead() ) {
@@ -434,7 +432,7 @@
       QString filename;
       int onlyDir = -1;
       if ( parseDiffLine(
-         line, path1, len1, path2, len2, type, filename, onlyDir
+         line, path1, path2, type, filename, onlyDir
       ) == true ) {
          XX_LOCAL_TRACE( "ERROR" );
          errors << "Diff error:" << endl;
@@ -445,7 +443,7 @@
 #ifdef LOCAL_TRACE
       XX_TRACE( line
                 << typeString[ type ] << "   " 
-                << filename.toLatin1().constData() << "   "
+                << filename.toLocal8Bit().constData() << "   "
                 << onlyDir );
       if ( type == UNKNOWN ) {
          throw XxInternalError( XX_EXC_PARAMS );
diff -urb ./src/builderFiles2.cpp ./src/builderFiles2.cpp
--- ./src/builderFiles2.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/builderFiles2.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -31,11 +31,11 @@
 #include <diffutils.h>
 #include <buffer.h>
 
-#include <QtCore/QString>
-#include <QtCore/QByteArray>
-#include <QtCore/QTextStream>
-#include <QtCore/QFile>
-#include <QtCore/QProcess>
+#include <QString>
+#include <QByteArray>
+#include <QTextStream>
+#include <QFile>
+#include <QProcess>
 
 #include <stdexcept>
 #include <stdio.h>
@@ -86,7 +86,7 @@
     * this code taken from "ediff.c" by David MacKenzie, a published,
     * uncopyrighted program to translate diff output into plain English
     */
-   QByteArray lineBa = line.toLatin1();
+   QByteArray lineBa = line.toLocal8Bit();
    const char* buf = lineBa.constData();
 
    bool error = true;
@@ -221,7 +221,9 @@
 XxBuilderFiles2::XxBuilderFiles2( bool useInternalDiff ) :
    XxBuilder(),
    _useInternalDiff( useInternalDiff )
-{}
+{
+   (void)_useInternalDiff; // suppress "unused" warning
+}
 
 //------------------------------------------------------------------------------
 //
@@ -306,7 +308,7 @@
 
       switch ( type ) {
          case XxLine::INSERT_1: {
-            XX_LOCAL_TRACE( XxLine::mapToString( type ).toLatin1().constData() );
+            XX_LOCAL_TRACE( XxLine::mapToString( type ).toLocal8Bit().constData() );
             XX_LOCAL_TRACE( "Output: f1n1=" << f1n1 << "  f1n2=" << f1n2 <<
                             "  f2n1=" << f2n1 << "  f2n2=" << f2n2 );
 
@@ -327,7 +329,7 @@
          } break;
 
          case XxLine::INSERT_2: {
-            XX_LOCAL_TRACE( XxLine::mapToString( type ).toLatin1().constData() );
+            XX_LOCAL_TRACE( XxLine::mapToString( type ).toLocal8Bit().constData() );
             XX_LOCAL_TRACE( "Output: f1n1=" << f1n1 << "  f1n2=" << f1n2 <<
                             "  f2n1=" << f2n1 << "  f2n2=" << f2n2 );
 
@@ -348,7 +350,7 @@
          } break;
 
          case XxLine::DIFF_ALL: {
-            XX_LOCAL_TRACE( XxLine::mapToString( type ).toLatin1().constData() );
+            XX_LOCAL_TRACE( XxLine::mapToString( type ).toLocal8Bit().constData() );
             XX_LOCAL_TRACE( "Output: f1n1=" << f1n1 << "  f1n2=" << f1n2 <<
                             "  f2n1=" << f2n1 << "  f2n2=" << f2n2 );
 
@@ -381,7 +383,7 @@
          } break;
 
          case XxLine::SAME: {
-            XX_LOCAL_TRACE( XxLine::mapToString( type ).toLatin1().constData() );
+            XX_LOCAL_TRACE( XxLine::mapToString( type ).toLocal8Bit().constData() );
          } break;
 
          /* Used to ignore a line */
diff -urb ./src/builderFiles3.cpp ./src/builderFiles3.cpp
--- ./src/builderFiles3.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/builderFiles3.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -30,11 +30,11 @@
 #include <util.h>
 #include <buffer.h>
 
-#include <QtCore/QString>
-#include <QtCore/QByteArray>
-#include <QtCore/QTextStream>
-#include <QtCore/QFile>
-#include <QtCore/QProcess>
+#include <QString>
+#include <QByteArray>
+#include <QTextStream>
+#include <QFile>
+#include <QProcess>
 
 #include <stdexcept>
 #include <stdio.h>
@@ -209,7 +209,7 @@
       ); \
   }
 
-   QByteArray lineBa = line.toLatin1();
+   QByteArray lineBa = line.toLocal8Bit();
    const char* buf = lineBa.constData();
 
    XX_LOCAL_TRACE( "" );
@@ -485,7 +485,7 @@
 
 #ifdef XX_DEBUG
       XX_LOCAL_TRACE( "ParseDiffLine results: " );
-      XX_LOCAL_TRACE( XxLine::mapToString( type ).toLatin1().constData() );
+      XX_LOCAL_TRACE( XxLine::mapToString( type ).toLocal8Bit().constData() );
       XX_LOCAL_TRACE( "  sno=" << sno );
       XX_LOCAL_TRACE( "  f1n1=" << f1n1 << "  f1n2=" << f1n2 );
       XX_LOCAL_TRACE( "  f2n1=" << f2n1 << "  f2n2=" << f2n2 );
diff -urb ./src/builderSingle.cpp ./src/builderSingle.cpp
--- ./src/builderSingle.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/builderSingle.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -28,7 +28,7 @@
 #include <diffs.h>
 #include <buffer.h>
 
-#include <QtCore/QTextStream>
+#include <QTextStream>
 
 #include <stdio.h>
 #include <iostream>
diff -urb ./src/builderUnmerge.cpp ./src/builderUnmerge.cpp
--- ./src/builderUnmerge.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/builderUnmerge.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -29,9 +29,9 @@
 #include <buffer.h>
 #include <resources.h>
 
-#include <QtCore/QByteArray>
-#include <QtCore/QTextStream>
-#include <QtCore/QRegExp>
+#include <QByteArray>
+#include <QTextStream>
+#include <QRegExp>
 
 #include <stdio.h>
 #include <iostream>
diff -urb ./src/central.cpp ./src/central.cpp
--- ./src/central.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/central.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -35,19 +35,19 @@
 #include <borderLabel.h>
 #include <help.h>
 
-#include <QtGui/QPainter>
-#include <QtGui/QBrush>
-#include <QtGui/QPen>
-#include <QtGui/QColor>
-#include <QtGui/QLayout>
-#include <QtGui/QShortcut>
-
-#include <QtGui/QApplication>
-#include <QtGui/QClipboard>
-#include <QtGui/QHBoxLayout>
-#include <QtGui/QFrame>
-#include <QtGui/QLabel>
-#include <QtGui/QVBoxLayout>
+#include <QPainter>
+#include <QBrush>
+#include <QPen>
+#include <QColor>
+#include <QLayout>
+#include <QShortcut>
+
+#include <QApplication>
+#include <QClipboard>
+#include <QHBoxLayout>
+#include <QFrame>
+#include <QLabel>
+#include <QVBoxLayout>
 
 #include <math.h>
 #include <stdio.h>
diff -urb ./src/central.h ./src/central.h
--- ./src/central.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/central.h	2019-06-26 09:20:52.000000000 -0700
@@ -40,12 +40,12 @@
 #endif
 
 #ifndef INCL_QT_QMAINWINDOW
-#include <QtGui/QMainWindow>
+#include <QMainWindow>
 #define INCL_QT_QMAINWINDOW
 #endif
 
 #ifndef INCL_QT_QFRAME
-#include <QtGui/QFrame>
+#include <QFrame>
 #define INCL_QT_QFRAME
 #endif
 
diff -urb ./src/cmdline.cpp ./src/cmdline.cpp
--- ./src/cmdline.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/cmdline.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -36,9 +36,9 @@
 
 #include <kdeSupport.h>
 
-#include <QtGui/QApplication>
-#include <QtCore/QByteArray>
-#include <QtCore/QTextStream>
+#include <QApplication>
+#include <QByteArray>
+#include <QTextStream>
 
 /*#define getopt xxdiff_getopt*/
 #include <getopt.h>
@@ -289,8 +289,12 @@
      "Sets the X display (default is $DISPLAY)."
    }, 
    { "style", 0, true, 's',
-     "Sets the application GUI style. Possible values are motif, windows, "
-     "and platinum. "
+     "Sets the application GUI style. Possible values are fusion, windows, "
+     "or QtCurve when that style has been installed. "
+   },
+   { "platform", 0, true, 'x',
+      "Sets the platform plugin to be used. For instance, on OS X one can use "
+      "cocoa or xcb as platform plugins."
    }, 
    { "geometry", 0, true, 'g',
      "Sets the client geometry of the main widget."
@@ -339,6 +343,7 @@
 //------------------------------------------------------------------------------
 //
 XxCmdline::XxCmdline() :
+   _forcePlatform( false ),
    _forceStyle( false ),
    _forceGeometry( false ),
    _forceFont( false ),
@@ -434,7 +439,7 @@
    while ( true ) {
       int c = getopt_long( argc,
                            argv,
-                           shortOptions.toLatin1().constData(),
+                           shortOptions.toLocal8Bit().constData(),
                            longOptions,
                            &optionIndex );
       if ( c == -1 ) {
@@ -642,7 +647,8 @@
          } break;
 
          case 'd':
-         case 's':
+         case 's':  // --style
+         case 'x':  // --platform
          case 'G':
          case 'g':
          case 'F':
@@ -762,7 +768,7 @@
    if ( !_promptForFiles )
    {
       for ( ii = 0; ii < _nbFilenames; ++ii ) {
-         _filenames[ ii ] = QString::fromLatin1( argv[ optind + ii ] ).trimmed();
+         _filenames[ ii ] = QString::fromLocal8Bit( argv[ optind + ii ] ).trimmed();
       }
    }
    
@@ -771,6 +777,9 @@
       if ( strncmp( _qtOptions[ ii ], "-style", 6 ) == 0 ) {
          _forceStyle = true;
       }
+      else if ( strncmp( _qtOptions[ ii ], "-platform", 9 ) == 0 ) {
+         _forcePlatform = true;
+      }
       else if ( strncmp( _qtOptions[ ii ], "-geometry", 9 ) == 0 ) {
          _forceGeometry = true;
       }
diff -urb ./src/cmdline.h ./src/cmdline.h
--- ./src/cmdline.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/cmdline.h	2019-06-26 09:20:52.000000000 -0700
@@ -117,6 +117,7 @@
    /*----- data members -----*/
 
    // Cmdline-related variables.
+   bool          _forcePlatform;
    bool          _forceStyle;
    bool          _forceGeometry;
    bool          _forceFont;
diff -urb ./src/copyLabel.cpp ./src/copyLabel.cpp
--- ./src/copyLabel.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/copyLabel.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -28,13 +28,13 @@
 
 #include <kdeSupport.h>
 
-#include <QtGui/QToolTip>
+#include <QToolTip>
 
-#include <QtGui/QApplication>
-#include <QtGui/QClipboard>
-#include <QtGui/QResizeEvent>
-#include <QtGui/QMouseEvent>
-#include <QtGui/QLabel>
+#include <QApplication>
+#include <QClipboard>
+#include <QResizeEvent>
+#include <QMouseEvent>
+#include <QLabel>
 
 
 /*==============================================================================
diff -urb ./src/copyLabel.h ./src/copyLabel.h
--- ./src/copyLabel.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/copyLabel.h	2019-06-26 09:20:52.000000000 -0700
@@ -36,7 +36,7 @@
 #endif
 
 #ifndef INCL_QT_QLABEL
-#include <QtGui/QLabel>
+#include <QLabel>
 #define INCL_QT_QLABEL
 #endif
 
diff -urb ./src/diffs.cpp ./src/diffs.cpp
--- ./src/diffs.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/diffs.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -28,7 +28,7 @@
 #include <buffer.h>
 #include <resources.h>
 
-#include <QtCore/QTextStream>
+#include <QTextStream>
 
 #include <list>
 #include <algorithm>
@@ -893,7 +893,7 @@
    }
 
    // for ( int ii = 0; ii < 4; ++ii ) {
-   //    XX_TRACE( tags[ii].toLatin1().constData() );
+   //    XX_TRACE( tags[ii].toLocal8Bit().constData() );
    // }
 
    bool foundUnsel = false;
diff -urb ./src/diffs.h ./src/diffs.h
--- ./src/diffs.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/diffs.h	2019-06-26 09:20:52.000000000 -0700
@@ -40,7 +40,7 @@
 #endif
 
 #ifndef INCL_QT_QOBJECT
-#include <QtCore/QObject>
+#include <QObject>
 #define INCL_QT_QOBJECT
 #endif
 
diff -urb ./src/diffutils.cpp ./src/diffutils.cpp
--- ./src/diffutils.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/diffutils.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -246,7 +246,7 @@
    for ( QStringList::Iterator it = out_args.begin();
          it != out_args.end();
          ++it ) {
-      argv[argc++] = strdup( (*it).toLatin1().constData() );
+      argv[argc++] = strdup( (*it).toLocal8Bit().constData() );
    }
    argv[argc] = 0;
 
diff -urb ./src/diffutils.h ./src/diffutils.h
--- ./src/diffutils.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/diffutils.h	2019-06-26 09:20:52.000000000 -0700
@@ -32,7 +32,7 @@
 #endif
 
 #ifndef INCL_QT_QSTRING
-#include <QtCore/QString>
+#include <QString>
 #define INCL_QT_QSTRING
 #endif
 
diff -urb ./src/exceptions.cpp ./src/exceptions.cpp
--- ./src/exceptions.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/exceptions.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -28,7 +28,7 @@
 #include <cmdline.h>
 #include <help.h>
 
-#include <QtCore/QTextStream>
+#include <QTextStream>
 
 #include <iostream>
 #include <string.h> // strerror
@@ -150,7 +150,7 @@
    oss << "Internal error." << endl << endl;
    oss << "There has been an internal error within xxdiff." << endl
        << "To report bugs, please use the sourceforge bug tracker" << endl
-       << "at http://sourceforge.net/tracker/?group_id=2198" << endl
+       << "at https://sourceforge.net/p/xxdiff/bugs/" << endl
        << "and log the above information above and if possible," << endl
        << "the files that caused the error, and as much detail as" << endl
        << "you can to reproduce the error.";
@@ -161,9 +161,8 @@
 // I'll know what's going on at least when developing in debug mode.
 #ifdef XX_DEBUG
    std::cerr << "Throwing exception:" << std::endl;
-   std::cerr << _msg.toLatin1().constData() << std::endl;
+   std::cerr << _msg.toLocal8Bit().constData() << std::endl;
 #endif
 }
 
 XX_NAMESPACE_END
-
diff -urb ./src/exceptions.h ./src/exceptions.h
--- ./src/exceptions.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/exceptions.h	2019-06-26 09:20:52.000000000 -0700
@@ -33,12 +33,12 @@
 #endif
 
 #ifndef INCL_QT_QSTRING
-#include <QtCore/QString>
+#include <QString>
 #define INCL_QT_QSTRING
 #endif
 
 #ifndef INCL_QT_QTEXTSTREAM
-#include <QtCore/QTextStream>
+#include <QTextStream>
 #define INCL_QT_QTEXTSTREAM
 #endif
 
diff -urb ./src/getopt.c ./src/getopt.c
--- ./src/getopt.c	2016-05-15 15:55:57.000000000 -0700
+++ ./src/getopt.c	2019-06-26 09:20:52.000000000 -0700
@@ -390,6 +390,8 @@
      char *const *argv;
      const char *optstring;
 {
+   (void)argc; /* suppress "unused" warning */
+   (void)argv; /* suppress "unused" warning */
   /* Start processing options with ARGV-element 1 (since ARGV-element 0
      is the program name); the sequence of previously skipped
      non-option ARGV-elements is empty.  */
diff -urb ./src/help.cpp ./src/help.cpp
--- ./src/help.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/help.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -32,9 +32,9 @@
 #include <resParser.h>
 
 #include <kdeSupport.h>
-#include <QtGui/QPixmap>
-#include <QtCore/QTextStream>
-#include <QtGui/QVBoxLayout>
+#include <QPixmap>
+#include <QTextStream>
+#include <QVBoxLayout>
 
 namespace XX_NAMESPACE_PREFIX { namespace Manual {
 #if !defined(WINDOWS) && !defined(__CYGWIN__)
@@ -44,15 +44,15 @@
 #endif
 }}
 
-#include <QtGui/QDialog>
-#include <QtGui/QMessageBox>
-#include <QtGui/QLayout>
-#include <QtGui/QLabel>
-#include <QtGui/QPushButton>
-#include <QtGui/QPalette>
-#include <QtGui/QTextBrowser>
-#include <QtCore/QByteArray>
-#include <QtGui/QLineEdit>
+#include <QDialog>
+#include <QMessageBox>
+#include <QLayout>
+#include <QLabel>
+#include <QPushButton>
+#include <QPalette>
+#include <QTextBrowser>
+#include <QByteArray>
+#include <QLineEdit>
 
 #include <iostream>
 #include <stdio.h>
@@ -599,7 +599,7 @@
 //
 QString XxHelp::xmlize( const QString& in )
 {
-   QByteArray inBa =  in.toLatin1();
+   QByteArray inBa =  in.toLocal8Bit();
    const char* inc = inBa.constData();
    QString out;
    for ( int ii = 0; ii < in.length(); ++ii ) {
diff -urb ./src/help.h ./src/help.h
--- ./src/help.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/help.h	2019-06-26 09:20:52.000000000 -0700
@@ -36,7 +36,7 @@
 #endif
 
 #ifndef INCL_QT_QDIALOG
-#include <QtGui/QDialog>
+#include <QDialog>
 #define INCL_QT_QDIALOG
 #endif
 
diff -urb ./src/hordiffImp.cpp ./src/hordiffImp.cpp
--- ./src/hordiffImp.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/hordiffImp.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -27,7 +27,7 @@
 #include <hordiffImp.h>
 #include <resources.h>
 
-#include <QtCore/QByteArray>
+#include <QByteArray>
 
 #ifndef COMPILER_MIPSPRO
 #include <cctype> // isspace()
diff -urb ./src/line.h ./src/line.h
--- ./src/line.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/line.h	2019-06-26 09:20:52.000000000 -0700
@@ -41,7 +41,7 @@
 #endif
 
 #ifndef INCL_QT_QSTRING
-#include <QtCore/QString>
+#include <QString>
 #define INCL_QT_QSTRING
 #endif
 
diff -urb ./src/lineNumbers.cpp ./src/lineNumbers.cpp
--- ./src/lineNumbers.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/lineNumbers.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -32,14 +32,14 @@
 #include <buffer.h>
 #include <text.h>
 
-#include <QtGui/QPainter>
-#include <QtGui/QBrush>
-#include <QtGui/QPen>
-#include <QtGui/QColor>
-
-#include <QtGui/QApplication>
-#include <QtGui/QClipboard>
-#include <QtGui/QFrame>
+#include <QPainter>
+#include <QBrush>
+#include <QPen>
+#include <QColor>
+
+#include <QApplication>
+#include <QClipboard>
+#include <QFrame>
 
 #include <math.h>
 #include <stdio.h>
diff -urb ./src/lineNumbers.h ./src/lineNumbers.h
--- ./src/lineNumbers.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/lineNumbers.h	2019-06-26 09:20:52.000000000 -0700
@@ -36,7 +36,7 @@
 #endif
 
 #ifndef INCL_QT_QFRAME
-#include <QtGui/QFrame>
+#include <QFrame>
 #define INCL_QT_QFRAME
 #endif
 
diff -urb ./src/main.cpp ./src/main.cpp
--- ./src/main.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/main.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -91,7 +91,7 @@
       }
    }
    catch ( const XxError& ex ) {
-      std::cerr << ex.getMsg().toAscii().constData() << std::endl;
+      std::cerr << ex.getMsg().toLocal8Bit().constData() << std::endl;
       // Note: we're casting for Windows MSVC streams which are broken.
    }
    catch ( const std::exception& ex ) {
diff -urb ./src/markers.cpp ./src/markers.cpp
--- ./src/markers.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/markers.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -26,20 +26,20 @@
 
 #include <markers.h>
 
-#include <QtGui/QFileDialog>
-#include <QtCore/QFileInfo>
-#include <QtCore/QString>
-#include <QtCore/QDir>
-
-#include <QtGui/QRadioButton>
-#include <QtGui/QLineEdit>
-#include <QtGui/QLabel>
-#include <QtGui/QCheckBox>
-
-#include <QtGui/QLayout>
-#include <QtGui/QPushButton>
-#include <QtGui/QHBoxLayout>
-#include <QtGui/QVBoxLayout>
+#include <QFileDialog>
+#include <QFileInfo>
+#include <QString>
+#include <QDir>
+
+#include <QRadioButton>
+#include <QLineEdit>
+#include <QLabel>
+#include <QCheckBox>
+
+#include <QLayout>
+#include <QPushButton>
+#include <QHBoxLayout>
+#include <QVBoxLayout>
 
 XX_NAMESPACE_BEGIN
 
@@ -167,7 +167,7 @@
 
    _buttonOk = new QPushButton;
    _buttonOk->setText( trUtf8( "Ok" ) );
-   _buttonOk->setDefault( TRUE );
+   _buttonOk->setDefault( true );
    hlayout->addWidget( _buttonOk );
    hlayout->addItem( new QSpacerItem( 20, 20, QSizePolicy::Expanding, QSizePolicy::Minimum ) );
 
@@ -253,7 +253,7 @@
    
    // Hack to embed XxMarkersWidget into the QFileDialog, since the
    // convenient Qt3 addWidgets doesn't exist anymore
-   QVBoxLayout *l = qFindChild<QVBoxLayout*>(this);
+   QVBoxLayout *l = this->findChild<QVBoxLayout*>(); //qFindChild<QVBoxLayout*>(this);
    Q_ASSERT(l);
    _markersWidget = new XxMarkersWidget( threeWay );
    l->addWidget(_markersWidget);
@@ -272,7 +272,7 @@
 )
 {
    XxMarkersFileDialog* dlg = new XxMarkersFileDialog(
-      startWith, filter, TRUE, threeWay, parent
+      startWith, filter, true, threeWay, parent
    );
 
    QString result;
diff -urb ./src/markers.h ./src/markers.h
--- ./src/markers.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/markers.h	2019-06-26 09:20:52.000000000 -0700
@@ -37,7 +37,7 @@
 #endif
 
 #ifndef INCL_STD_QFILEDIALOG
-#include <QtGui/QFileDialog>
+#include <QFileDialog>
 #define INCL_STD_QFILEDIALOG
 #endif
 
diff -urb ./src/merged.cpp ./src/merged.cpp
--- ./src/merged.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/merged.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -31,19 +31,19 @@
 #include <diffs.h>
 #include <buffer.h>
 
-#include <QtGui/QPainter>
-#include <QtGui/QBrush>
-#include <QtGui/QPen>
-#include <QtGui/QColor>
-#include <QtGui/QMenu>
-#include <QtGui/QMenuBar>
-#include <QtGui/QLayout>
-#include <QtGui/QCloseEvent>
-
-#include <QtGui/QApplication>
-#include <QtGui/QClipboard>
-#include <QtGui/QHBoxLayout>
-#include <QtGui/QVBoxLayout>
+#include <QPainter>
+#include <QBrush>
+#include <QPen>
+#include <QColor>
+#include <QMenu>
+#include <QMenuBar>
+#include <QLayout>
+#include <QCloseEvent>
+
+#include <QApplication>
+#include <QClipboard>
+#include <QHBoxLayout>
+#include <QVBoxLayout>
 
 #include <math.h>
 #include <stdio.h>
diff -urb ./src/merged.h ./src/merged.h
--- ./src/merged.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/merged.h	2019-06-26 09:20:52.000000000 -0700
@@ -44,17 +44,17 @@
 #endif
 
 #ifndef INCL_QT_QMAINWINDOW
-#include <QtGui/QMainWindow>
+#include <QMainWindow>
 #define INCL_QT_QMAINWINDOW
 #endif
 
 #ifndef INCL_QT_QFRAME
-#include <QtGui/QFrame>
+#include <QFrame>
 #define INCL_QT_QFRAME
 #endif
 
 #ifndef INCL_QT_QWIDGET
-#include <QtGui/QWidget>
+#include <QWidget>
 #define INCL_QT_QWIDGET
 #endif
 
diff -urb ./src/optionsDialog.cpp ./src/optionsDialog.cpp
--- ./src/optionsDialog.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/optionsDialog.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -32,24 +32,24 @@
 
 #include <kdeSupport.h>
 
-#include <QtGui/QTabWidget>
-#include <QtGui/QTextEdit>
-#include <QtGui/QLineEdit>
-#include <QtGui/QCheckBox>
-#include <QtGui/QRadioButton>
-#include <QtGui/QPushButton>
-#include <QtGui/QSpinBox>
-#include <QtGui/QListWidgetItem>
-#include <QtGui/QListWidget>
-#include <QtGui/QColor>
-#include <QtGui/QColorDialog>
-#include <QtGui/QFontDialog>
-#include <QtGui/QLabel>
-#include <QtGui/QComboBox>
-#include <QtCore/QString>
-#include <QtGui/QPainter>
-#include <QtCore/QMetaType>
-#include <QtGui/QItemDelegate>
+#include <QTabWidget>
+#include <QTextEdit>
+#include <QLineEdit>
+#include <QCheckBox>
+#include <QRadioButton>
+#include <QPushButton>
+#include <QSpinBox>
+#include <QListWidgetItem>
+#include <QListWidget>
+#include <QColor>
+#include <QColorDialog>
+#include <QFontDialog>
+#include <QLabel>
+#include <QComboBox>
+#include <QString>
+#include <QPainter>
+#include <QMetaType>
+#include <QItemDelegate>
 
 #include <stdlib.h>
 
@@ -143,6 +143,7 @@
 //
 XxColoredItem::XxColoredItem( XxColor color )
 {
+   (void)_resources; // suppress "unused" warning
    XxColoredItemData data( color, XxResParser::getColorName( color ) );
    setData( Qt::DisplayRole, qVariantFromValue( data ) );
 }
@@ -153,39 +154,45 @@
 {
 }
 
+// copied from Qt 4.8's qvariant.h:
+// template<typename T> inline T qvariant_cast(const QVariant &variant)
+// {
+//    return qvariant_cast<T>(variant);
+// }
+
 //------------------------------------------------------------------------------
 //
 inline XxColor XxColoredItem::color() const
 {
-   return qVariantValue<XxColoredItemData>( data( Qt::DisplayRole ) )._color;
+   return qvariant_cast<XxColoredItemData>( data( Qt::DisplayRole ) )._color;
 }
 
 //------------------------------------------------------------------------------
 //
 inline QColor XxColoredItem::foreColor() const
 {
-   return qVariantValue<XxColoredItemData>( data( Qt::DisplayRole ) )._foreColor;
+   return qvariant_cast<XxColoredItemData>( data( Qt::DisplayRole ) )._foreColor;
 }
 
 //------------------------------------------------------------------------------
 //
 inline QColor XxColoredItem::backColor() const
 {
-   return qVariantValue<XxColoredItemData>( data( Qt::DisplayRole ) )._backColor;
+   return qvariant_cast<XxColoredItemData>( data( Qt::DisplayRole ) )._backColor;
 }
 
 //------------------------------------------------------------------------------
 //
 inline bool XxColoredItem::modified() const
 {
-   return qVariantValue<XxColoredItemData>( data( Qt::DisplayRole ) )._modified;
+   return qvariant_cast<XxColoredItemData>( data( Qt::DisplayRole ) )._modified;
 }
 
 //------------------------------------------------------------------------------
 //
 void XxColoredItem::setForeColor( const QColor& color)
 {
-   XxColoredItemData data = qVariantValue<XxColoredItemData>( this->data( Qt::DisplayRole ) );
+   XxColoredItemData data = qvariant_cast<XxColoredItemData>( this->data( Qt::DisplayRole ) );
    data._foreColor = color;
    setData( Qt::DisplayRole, qVariantFromValue( data ) );
 }
@@ -194,7 +201,7 @@
 //
 void XxColoredItem::setBackColor( const QColor& color)
 {
-   XxColoredItemData data = qVariantValue<XxColoredItemData>( this->data( Qt::DisplayRole ) );
+   XxColoredItemData data = qvariant_cast<XxColoredItemData>( this->data( Qt::DisplayRole ) );
    data._backColor = color;
    setData( Qt::DisplayRole, qVariantFromValue( data ) );
 }
@@ -203,7 +210,7 @@
 //
 void XxColoredItem::setModified( const bool modified )
 {
-   XxColoredItemData data = qVariantValue<XxColoredItemData>( this->data( Qt::DisplayRole ) );
+   XxColoredItemData data = qvariant_cast<XxColoredItemData>( this->data( Qt::DisplayRole ) );
    data._modified = modified;
    setData( Qt::DisplayRole, qVariantFromValue( data ) );
 }
@@ -260,7 +267,7 @@
 {
    painter->save();
 
-   XxColoredItemData data = qVariantValue<XxColoredItemData>(index.data());
+   XxColoredItemData data = qvariant_cast<XxColoredItemData>(index.data());
 
    // Font.
    painter->setFont( _resources->getFontText() );
diff -urb ./src/overview.cpp ./src/overview.cpp
--- ./src/overview.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/overview.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -30,14 +30,14 @@
 #include <diffs.h>
 #include <buffer.h>
 
-#include <QtGui/QPainter>
-#include <QtGui/QBrush>
-#include <QtGui/QPen>
-#include <QtGui/QColor>
-#include <QtGui/QWheelEvent>
-#include <QtGui/QResizeEvent>
-#include <QtGui/QFrame>
-#include <QtGui/QMouseEvent>
+#include <QPainter>
+#include <QBrush>
+#include <QPen>
+#include <QColor>
+#include <QWheelEvent>
+#include <QResizeEvent>
+#include <QFrame>
+#include <QMouseEvent>
 
 #include <math.h>
 
diff -urb ./src/overview.h ./src/overview.h
--- ./src/overview.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/overview.h	2019-06-26 09:20:52.000000000 -0700
@@ -36,7 +36,7 @@
 #endif
 
 #ifndef INCL_QT_QFRAME
-#include <QtGui/QFrame>
+#include <QFrame>
 #define INCL_QT_QFRAME
 #endif
 
diff -urb ./src/resParser.cpp ./src/resParser.cpp
--- ./src/resParser.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/resParser.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -43,16 +43,16 @@
 
 #include <kdeSupport.h>
 
-#include <QtGui/QKeySequence>
-#include <QtGui/QApplication>
-#include <QtGui/QFont>
-#include <QtCore/QFile>
-#include <QtCore/QFileInfo>
-#include <QtCore/QByteArray>
-#include <QtCore/QString>
-#include <QtGui/QStyleFactory>
-#include <QtGui/QDesktopWidget>
-#include <QtCore/QTextStream>
+#include <QKeySequence>
+#include <QApplication>
+#include <QFont>
+#include <QFile>
+#include <QFileInfo>
+#include <QByteArray>
+#include <QString>
+#include <QStyleFactory>
+#include <QDesktopWidget>
+#include <QTextStream>
 
 #include <stdexcept>
 #include <iostream>
@@ -701,7 +701,7 @@
    int t = -1;
    int w = -1;
    int h = -1;
-   QByteArray valBa = val.toLatin1();
+   QByteArray valBa = val.toLocal8Bit();
    const char* vchar = valBa.constData();
    if ( sscanf( vchar, "%dx%d+%d+%d", &w, &h, &l, &t ) == 4 ) {
       geometry = QRect( l, t, w, h );
@@ -794,7 +794,7 @@
       QString os;
       QTextStream oss( &os );
       oss << "Unknown " << errmsg << ": " << name << flush;
-      resParsererror( NULL, os.toLatin1().constData() );
+      resParsererror( NULL, os.toLocal8Bit().constData() );
    }
    num = ERROR_TOKEN;
    return ERROR_TOKEN;
@@ -1180,7 +1180,7 @@
          astr = QKeySequence( aval ).toString();
       }
       os << accelStr << "." << accelList[ii]._name << ": \""
-         << astr.toLatin1().constData() << "\"" << endl;
+         << astr.toLocal8Bit().constData() << "\"" << endl;
    }
 
    const QFont& fontApp = res.getFontApp();
@@ -1232,7 +1232,7 @@
       XxCommand bo = XxCommand(commandList[ii]._token);
       const QString& b1 = res.getCommand( bo );
       os << commandStr << "." << commandList[ii]._name << ": \""
-         << b1.toLatin1().constData() << "\"" << endl;
+         << b1.toLocal8Bit().constData() << "\"" << endl;
    }
 
    int nbcommandSwitch = sizeof(commandSwitchList)/sizeof(StringToken);
@@ -1242,7 +1242,7 @@
       XxCommandSwitch bo = XxCommandSwitch(commandSwitchList[ii]._token);
       const QString& b1 = res.getCommandSwitch( bo );
       os << commandSwitchStr << "." << commandSwitchList[ii]._name << ": \""
-         << b1.toLatin1().constData() << "\"" << endl;
+         << b1.toLocal8Bit().constData() << "\"" << endl;
    }
 
    const char* initSwitchStr = searchTokenName( kwdList, kwdList_size, INITSW );
@@ -1270,7 +1270,7 @@
       XxTag bo = XxTag(tagList[ii]._token);
       const QString& b1 = res.getTag( bo );
       os << tagStr << "." << tagList[ii]._name << ": \""
-         << b1.toLatin1().constData() << "\"" << endl;
+         << b1.toLocal8Bit().constData() << "\"" << endl;
    }
 
    os << searchTokenName( kwdList, kwdList_size, CLIPBOARD_HEAD_FORMAT ) << ": \""
diff -urb ./src/resParser.h ./src/resParser.h
--- ./src/resParser.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/resParser.h	2019-06-26 09:20:52.000000000 -0700
@@ -36,12 +36,12 @@
 #endif
 
 #ifndef INCL_QT_QSTRING
-#include <QtCore/QString>
+#include <QString>
 #define INCL_QT_QSTRING
 #endif
 
 #ifndef INCL_QT_QTEXTSTREAM
-#include <QtCore/QTextStream>
+#include <QTextStream>
 #define INCL_QT_QTEXTSTREAM
 #endif
 
diff -urb ./src/resParser.y ./src/resParser.y
--- ./src/resParser.y	2016-05-15 15:55:57.000000000 -0700
+++ ./src/resParser.y	2019-06-26 09:20:52.000000000 -0700
@@ -28,10 +28,10 @@
 #include <resParser.h>
 
 // Qt imports
-#include <QtCore/QString>
-#include <QtCore/QStringList>
-#include <QtCore/QRect>
-#include <QtGui/QStyleFactory>
+#include <QString>
+#include <QStringList>
+#include <QRect>
+#include <QStyleFactory>
 
 // The parser input is the resources object to fill in.
 #define RESOURCES  ( static_cast<XxResources*>(resources) )
@@ -217,7 +217,7 @@
                       QString err = QString( "Requested style key does not exist." );
                       err += QString( "\nValid styles are: " );
                       err += styles.join( ", " );
-                      yyerror( NULL, err.toLatin1().constData() );
+                      yyerror( NULL, err.toLocal8Bit().constData() );
                    }
                 }
                 ;
diff -urb ./src/resources.cpp ./src/resources.cpp
--- ./src/resources.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/resources.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -31,11 +31,11 @@
 #include <exceptions.h>
 #include <util.h>
 
-#include <QtGui/QColor>
-#include <QtCore/QObject>
-#include <QtGui/QApplication> // to get desktop
-#include <QtCore/QRegExp>
-#include <QtGui/QStyleFactory>
+#include <QColor>
+#include <QObject>
+#include <QApplication> // to get desktop
+#include <QRegExp>
+#include <QStyleFactory>
 
 #include <iostream>
 #include <string.h> // ::strcmp
@@ -98,9 +98,11 @@
    _preferredGeometry = _defaultGeometry;
    _styleKey =  // Default style.
 #ifdef Q_OS_MAC
-      "Macintosh (aqua)";
+      "Macintosh";
+#elif defined(Q_OS_WIN)
+      "Windows";
 #else
-      "Cleanlooks";
+      "";
 #endif
    _maximize = false;
 
@@ -117,6 +119,8 @@
    _accelerators[ ACCEL_EXIT_MERGED ] = Qt::Key_M;
    _accelerators[ ACCEL_EXIT_REJECT ] = Qt::Key_R;
                   
+   _accelerators[ ACCEL_SAVE_AS_LEFT ] = Qt::CTRL | Qt::SHIFT | Qt::Key_L;
+   _accelerators[ ACCEL_SAVE_AS_RIGHT ] = Qt::CTRL | Qt::SHIFT | Qt::Key_R;
    _accelerators[ ACCEL_SAVE_AS_MERGED ] = Qt::CTRL | Qt::Key_M;
 
    _accelerators[ ACCEL_SEARCH ] = Qt::CTRL | Qt::Key_S;
@@ -316,7 +320,7 @@
    // "cmp -s" barfs on directories.
    const char* editor = getenv( "EDITOR" );
    if ( editor != 0 ) {
-      _commands[ CMD_EDIT ] = QString::fromLatin1( editor );
+      _commands[ CMD_EDIT ] = QString::fromLocal8Bit( editor );
    }
    else {
       _commands[ CMD_EDIT ] = "xterm -e vi";
diff -urb ./src/resources.h ./src/resources.h
--- ./src/resources.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/resources.h	2019-06-26 09:20:52.000000000 -0700
@@ -32,22 +32,22 @@
 #endif
 
 #ifndef INCL_QT_QOBJECT
-#include <QtCore/QObject>
+#include <QObject>
 #define INCL_QT_QOBJECT
 #endif
 
 #ifndef INCL_QT_QCOLOR
-#include <QtGui/QColor>
+#include <QColor>
 #define INCL_QT_QCOLOR
 #endif
 
 #ifndef INCL_QT_QFONT
-#include <QtGui/QFont>
+#include <QFont>
 #define INCL_QT_QFONT
 #endif
 
 #ifndef INCL_QT_QRECT
-#include <QtCore/QRect>
+#include <QRect>
 #define INCL_QT_QFONT
 #endif
 
diff -urb ./src/scrollView.cpp ./src/scrollView.cpp
--- ./src/scrollView.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/scrollView.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -1,4 +1,5 @@
 /* -*- c-file-style: "xxdiff" -*- */
+/* kate: backspace-indents true; indent-pasted-text true; indent-width 3; keep-extra-spaces true; remove-trailing-spaces modified; replace-tabs true; replace-tabs-save true; syntax Tcl/Tk; tab-indents true; tab-width 3; */
 /******************************************************************************\
  * $RCSfile$
  *
@@ -27,11 +28,12 @@
 #include <scrollView.h>
 #include <app.h>
 
-#include <QtGui/QScrollBar>
-#include <QtCore/QSize>
-#include <QtGui/QFont>
-#include <QtGui/QFontMetrics>
-#include <QtGui/QWheelEvent>
+#include <QScrollBar>
+#include <QSize>
+#include <QFont>
+#include <QFontMetrics>
+#include <QWheelEvent>
+#include <QElapsedTimer>
 
 XX_NAMESPACE_BEGIN
 
@@ -55,7 +57,9 @@
    _displayHeight( 0 ),
    _textWidth( 0 ),
    _textHeight( 0 ),
-   _managingWheelEvent( false )
+   _managingWheelEvent( false ),
+   accidentalModifier(false),
+   lastWheelEventUnmodified(false)
 {
    // Initialize to null.  The derived classes create them.
    _hscroll = 0;
@@ -67,12 +71,21 @@
       _app, SIGNAL(textSizeChanged()),
       this, SLOT(adjustScrollbars())
    );
+#ifndef Q_OS_OSX
+   lastWheelEvent = new QElapsedTimer;
+   lastWheelEvent->start();
+#else
+   lastWheelEvent = NULL;
+#endif
 }
 
 //------------------------------------------------------------------------------
 //
 XxScrollView::~XxScrollView()
 {
+   if (lastWheelEvent) {
+      delete lastWheelEvent;
+   }
 }
 
 //------------------------------------------------------------------------------
@@ -315,8 +328,26 @@
 //
 void XxScrollView::wheelEvent( QWheelEvent* e )
 {
+#ifndef Q_OS_OSX
+   qint64 deltaT = lastWheelEvent->elapsed();
+#endif
    if ( e->modifiers() & Qt::ControlModifier ) {
+#ifndef Q_OS_OSX
+      // Pressing the Control/Command key within 200ms of the previous "unmodified" wheelevent
+      // is not allowed to cause text zooming; this prevents zooming due to inertial scrolling.
+      if (lastWheelEventUnmodified && deltaT < 200) {
+            accidentalModifier = true;
+      }
+      else {
+         // hold the Control/Command key for 1s without scrolling to re-allow text zooming
+         if (deltaT > 1000) {
+            accidentalModifier = false;
+         }
+      }
+      lastWheelEventUnmodified = false;
+#endif
       // Interactive font resize feature with mouse wheel.
+      if ( !accidentalModifier ) {
       if ( e->delta() > 0 ) {
          _app->fontSizeDecrease();
       }
@@ -324,13 +355,19 @@
          _app->fontSizeIncrease();
       }
    }
+   }
    else {
       if ( ! _managingWheelEvent ) {
           _managingWheelEvent = true;
           QApplication::sendEvent( _vscroll[0], e );
           _managingWheelEvent = false;
       }
+      lastWheelEventUnmodified = true;
+      accidentalModifier = false;
    }
+#ifndef Q_OS_OSX
+   lastWheelEvent->start();
+#endif
 }
 
 XX_NAMESPACE_END
diff -urb ./src/scrollView.h ./src/scrollView.h
--- ./src/scrollView.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/scrollView.h	2019-06-26 09:20:52.000000000 -0700
@@ -36,7 +36,7 @@
 #endif
 
 #ifndef INCL_QT_QWIDGET
-#include <QtGui/QWidget>
+#include <QWidget>
 #define INCL_QT_QWIDGET
 #endif
 
@@ -47,6 +47,7 @@
 class QScrollBar;
 class QSize;
 class QWheelEvent;
+class QElapsedTimer;
 
 XX_NAMESPACE_BEGIN
 
@@ -176,6 +177,13 @@
    //loop when the wheel event doesn't lead to a value change of the scrollbar
    bool _managingWheelEvent;
 
+   // state variables that help to prevent accidental text zooming
+   // due to using the Ctrl key during inertial scrolling.
+   // Qt/Mac does this behind the scenes.
+   QElapsedTimer *lastWheelEvent;
+   bool accidentalModifier;
+   bool lastWheelEventUnmodified;
+
 };
 
 XX_NAMESPACE_END
diff -urb ./src/searchDialog.cpp ./src/searchDialog.cpp
--- ./src/searchDialog.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/searchDialog.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -29,9 +29,9 @@
 #include <diffs.h>
 #include <app.h>
 
-#include <QtGui/QLineEdit>
-#include <QtGui/QPushButton>
-#include <QtGui/QComboBox>
+#include <QLineEdit>
+#include <QPushButton>
+#include <QComboBox>
 
 XX_NAMESPACE_BEGIN
 
diff -urb ./src/suicideMessageBox.h ./src/suicideMessageBox.h
--- ./src/suicideMessageBox.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/suicideMessageBox.h	2019-06-26 09:20:52.000000000 -0700
@@ -32,7 +32,7 @@
 #endif
 
 #ifndef INCL_QT_QMESSAGEBOX
-#include <QtGui/QMessageBox>
+#include <QMessageBox>
 #define INCL_QT_QMESSAGEBOX
 #endif
 
diff -urb ./src/text.cpp ./src/text.cpp
--- ./src/text.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/text.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -33,18 +33,18 @@
 
 #include <kdeSupport.h>
 
-#include <QtGui/QPainter>
-#include <QtGui/QBrush>
-#include <QtGui/QPen>
-#include <QtGui/QColor>
-#include <QtGui/QMenu>
-
-#include <QtGui/QApplication>
-#include <QtGui/QClipboard>
-#include <QtGui/QFrame>
-#include <QtGui/QResizeEvent>
-#include <QtGui/QMouseEvent>
-#include <QtGui/QWheelEvent>
+#include <QPainter>
+#include <QBrush>
+#include <QPen>
+#include <QColor>
+#include <QMenu>
+
+#include <QApplication>
+#include <QClipboard>
+#include <QFrame>
+#include <QResizeEvent>
+#include <QMouseEvent>
+#include <QWheelEvent>
 
 #include <math.h>
 #include <stdio.h>
@@ -148,7 +148,7 @@
       }
 
       XX_CHECK( rlen > 0 ); // always true, because xch < xend
-      QString str( QString::fromLatin1( renderedText + xch, rlen ) );
+      QString str( QString::fromLocal8Bit( renderedText + xch, rlen ) );
       int nw = fm.width( str, rlen );
 
 #ifndef XX_DRAWTEXT_DRAWS_BACKGROUND
@@ -544,7 +544,7 @@
             }
 
             XX_CHECK( rlen > 0 ); // always true, because xch < xend
-            chunk = QString::fromLatin1( renderedText + xch, rlen );
+            chunk = QString::fromLocal8Bit( renderedText + xch, rlen );
             // FIXME check somehow that this actually corresponds to the
             // rendered measure.
             QRect brect = fm.boundingRect(
@@ -859,7 +859,7 @@
             if ( text != 0 ) {
                QString adt;
                if ( len > 0 ) {
-                  adt = QString::fromLatin1( text, len );
+                  adt = QString::fromLocal8Bit( text, len );
                }
                if ( resources.getBoolOpt( BOOL_FORMAT_CLIPBOARD_TEXT )
                     == true ) {
@@ -947,7 +947,7 @@
          if ( text != 0 ) {
             QString adt;
             if ( len > 0 ) {
-               adt = QString::fromLatin1( text, len );
+               adt = QString::fromLocal8Bit( text, len );
             }
             if ( resources.getBoolOpt( BOOL_FORMAT_CLIPBOARD_TEXT )
                  == true ) {
diff -urb ./src/text.h ./src/text.h
--- ./src/text.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/text.h	2019-06-26 09:20:52.000000000 -0700
@@ -36,12 +36,12 @@
 #endif
 
 #ifndef INCL_QT_QFRAME
-#include <QtGui/QFrame>
+#include <QFrame>
 #define INCL_QT_QFRAME
 #endif
 
 #ifndef INCL_QT_QFONTMETRICS
-#include <QtGui/QFontMetrics>
+#include <QFontMetrics>
 #define INCL_QT_QFONTMETRICS
 #endif
 
diff -urb ./src/util.cpp ./src/util.cpp
--- ./src/util.cpp	2016-05-15 15:55:57.000000000 -0700
+++ ./src/util.cpp	2019-06-26 09:20:52.000000000 -0700
@@ -28,12 +28,12 @@
 #include <exceptions.h>
 #include <main.h>
 
-#include <QtCore/QString>
-#include <QtCore/QByteArray>
-#include <QtCore/QTextStream>
-#include <QtCore/QFileInfo>
-#include <QtCore/QRegExp>
-#include <QtCore/QDateTime>
+#include <QString>
+#include <QByteArray>
+#include <QTextStream>
+#include <QFileInfo>
+#include <QRegExp>
+#include <QDateTime>
 
 #include <iostream>
 #include <sys/types.h>
@@ -68,50 +68,6 @@
 
 namespace {
 
-bool installSigChldHandler(
-   void (*sigChldHandler)(int)
-)
-{
-// Disabled crud that doesn't work (it works only the first time, the second
-// time around the handler is called immediately upon setting up the handler).
-   (void)sigChldHandler;
-#ifdef DISABLED_ENABLED /* always false */
-   XX_ASSERT( sigChldHandler != 0 );
-
-   XX_TRACE( "Installing SIGCHLD handler." );
-
-   // sigset_t spm_o;
-   // sigprocmask( SIG_NOP, 0, &spm_o );
-   // XX_TRACE( "is SIGCHLD member=" <<
-   //           sigismember( &spm_o, SIGCHLD ) );
-   // sigemptyset( &spm_o );
-   // sigaddset( &spm_o, SIGCHLD );
-   // sigprocmask( SIG_BLOCK, &spm_o, 0 );
-
-   //
-   // Register a SIGCHLD handler.
-   //
-   // Note: under IRIX (untested with others), SA_NOCLDWAIT will not
-   // allow a redo diff to work. I don't know why.
-
-   struct sigaction sa;
-   sa.sa_flags = /*SA_SIGINFO | */SA_RESTART |
-      SA_RESETHAND | SA_NOCLDWAIT | SA_NOCLDSTOP;
-   sa.sa_handler = sigChldHandler;
-   sigset_t ss;
-   sigemptyset( &ss );
-   sa.sa_mask = ss;
-   //sa.sa_sigaction = 0; don't clear sa_sigaction for nothing...
-   // sa_handler and sa_sigaction may be sharing an union.
-   if ( ::sigaction( SIGCHLD, &sa, 0 ) != 0 ) {
-      // Ignore error.
-      XX_TRACE( "Error calling sigaction." );
-      return false;
-   }
-#endif
-   return true;
-}
-
 //------------------------------------------------------------------------------
 //
 // Returns permissions from QFileInfo in human readable format
@@ -190,14 +146,14 @@
       case 'n': { // - File name
          strcat( pformat, "s" );
          QString tmp;
-         tmp.sprintf( pformat, filename.toLatin1().constData() );
+         tmp.sprintf( pformat, filename.toLocal8Bit().constData() );
          target.append( tmp );
       } break;
 
       case 'N': { // - Quoted File name with dereference if symbolic link
          strcat( pformat, "s" );
          QString tmp;
-         tmp.sprintf( pformat, filename.toLatin1().constData() );
+         tmp.sprintf( pformat, filename.toLocal8Bit().constData() );
          if ( qfi.isSymLink() ) {
             tmp.append( "' -> `" );
             tmp.append( qfi.readLink() );
@@ -235,7 +191,7 @@
       case 'U': { // - User name of owner
          strcat( pformat, "s" );
          QString tmp;
-         tmp.sprintf( pformat,qfi.owner().toAscii().constData() );
+         tmp.sprintf( pformat,qfi.owner().toLocal8Bit().constData() );
          target.append( tmp );
       } break;
 
@@ -249,7 +205,7 @@
       case 'G': { // - Group name of owner
          strcat( pformat, "s" );
          QString tmp;
-         tmp.sprintf( pformat,qfi.group().toAscii().constData() );
+         tmp.sprintf( pformat,qfi.group().toLocal8Bit().constData() );
          target.append( tmp );
       } break;
 
@@ -280,7 +236,7 @@
          // It's not the exact same as stat( 2 ) does, but this is ISO 8601
          // and stat uses some weird syntax of it's own.
          tmp.sprintf( pformat,
-                      qfi.lastRead().toString( DATEFORMAT ).toAscii().constData() );
+                      qfi.lastRead().toString( DATEFORMAT ).toLocal8Bit().constData() );
          target.append( tmp );
       } break;
 
@@ -297,7 +253,7 @@
          // It's not the exact same as stat( 2 ) does, but this is ISO 8601
          // and stat uses some weird syntax of it's own.
          tmp.sprintf( pformat,
-                      qfi.lastModified().toString( DATEFORMAT ).toAscii().constData() );
+                      qfi.lastModified().toString( DATEFORMAT ).toLocal8Bit().constData() );
          target.append( tmp );
       } break;
 
@@ -383,7 +339,7 @@
          // and stat uses some weird syntax of it's own.
          tmp.sprintf(
             pformat,
-            ( QDateTime::currentDateTime() ).toString( DATEFORMAT ).toAscii().constData()
+            ( QDateTime::currentDateTime() ).toString( DATEFORMAT ).toLocal8Bit().constData()
          );
          target.append( tmp );
       } break;
@@ -403,7 +359,7 @@
          // and stat uses some weird syntax of it's own.
          tmp.sprintf(
             pformat,
-            ( QDateTime::currentDateTime() ).toString( DATEFORMAT ).toAscii().constData() );
+            ( QDateTime::currentDateTime() ).toString( DATEFORMAT ).toLocal8Bit().constData() );
          target.append( tmp );
       } break;
 
@@ -448,7 +404,7 @@
 {
    QString cmd = QString("cp '") + src + QString("' '") + dest + QString("'");
 
-   FILE* f = popen( cmd.toLatin1().constData(), "r" );
+   FILE* f = popen( cmd.toLocal8Bit().constData(), "r" );
    int r = pclose( f );
    return r;
 }
@@ -458,7 +414,7 @@
 int XxUtil::removeFile( const QString& src )
 {
    XX_ASSERT( !src.isEmpty() );
-   return unlink( src.toLatin1().constData() );
+   return unlink( src.toLocal8Bit().constData() );
 }
 
 //------------------------------------------------------------------------------
@@ -540,7 +496,7 @@
    int fd, bytes, i;
    char buffer[1024];
 
-   fd = open( filename.toLatin1().constData(), O_RDONLY );
+   fd = open( filename.toLocal8Bit().constData(), O_RDONLY );
    bytes = read( fd, (void *)buffer, 1024 );
    close( fd );
 
@@ -574,7 +530,7 @@
       return -1;
    }
    if ( pid == 0 ) {
-      QByteArray commandBa = command.toLatin1();
+      QByteArray commandBa = command.toLocal8Bit();
       char* argv[4];
       argv[0] = const_cast<char*>( "sh" );
       argv[1] = const_cast<char*>( "-c" );
@@ -669,7 +625,7 @@
    for ( QStringList::Iterator it = out_args.begin();
          it != out_args.end();
          ++it ) {
-      ofs << (*it).toLatin1().constData() << std::endl;
+      ofs << (*it).toLocal8Bit().constData() << std::endl;
    }
    ofs << " ----------------------------------------" << std::endl;
    ofs.close();
@@ -709,7 +665,7 @@
    //
    // Including anyway for now, because I absolutely don't have time right now.
 
-   char* format = strdup( masterformat.toLatin1().constData() );
+   char* format = strdup( masterformat.toLocal8Bit().constData() );
    char* dest = (char*) malloc( strlen( format ) + 1 );
    char* b = format;
    target = "";
@@ -793,7 +749,7 @@
 	   break;
        // use at() in case found+1 is past the end of the string
        QChar escapedChar = newFormat.at( found+1 );
-       switch( escapedChar.toAscii() ) {
+       switch( escapedChar.toLatin1() ) {
        case 'n':
 	   newFormat = newFormat.replace( found, 2, QChar( '\n' ) );
 	   break;
diff -urb ./src/util.h ./src/util.h
--- ./src/util.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/util.h	2019-06-26 09:20:52.000000000 -0700
@@ -32,17 +32,17 @@
 #endif
 
 #ifndef INCL_QT_QSTRING
-#include <QtCore/QString>
+#include <QString>
 #define INCL_QT_QSTRING
 #endif
 
 #ifndef INCL_QT_QFILEINFO
-#include <QtCore/QFileInfo>
+#include <QFileInfo>
 #define INCL_QT_QFILEINFO
 #endif
 
 #ifndef INCL_QT_QSTRINGLIST
-#include <QtCore/QStringList>
+#include <QStringList>
 #define INCL_QT_QSTRINGLIST
 #endif
 
diff -urb ./src/version.h ./src/version.h
--- ./src/version.h	2016-05-15 15:55:57.000000000 -0700
+++ ./src/version.h	2019-06-26 09:20:52.000000000 -0700
@@ -1 +1 @@
-#define XX_VERSION "4.0.1"
+#define XX_VERSION "5.0b1"
diff -urb ./src/xxdiff.pro ./src/xxdiff.pro
--- ./src/xxdiff.pro	2016-05-15 15:55:57.000000000 -0700
+++ ./src/xxdiff.pro	2019-06-26 09:20:52.000000000 -0700
@@ -29,6 +29,7 @@
 TEMPLATE = app
 CONFIG -= debug
 CONFIG += qt warn_on thread
+QT = widgets gui core
 
 DESTDIR=../bin
 TARGET = xxdiff
@@ -65,6 +66,9 @@
 QMAKE_YACC_HEADER = y.tab.h
 QMAKE_YACC_SOURCE = y.tab.c
 
+# Don't generate unused functions (warning suppression)
+QMAKE_LEXFLAGS = --noyy_push_state --noyy_pop_state --noyy_top_state
+
 LEXSOURCES = resParser.l
 
 YACCSOURCES = resParser.y
@@ -106,6 +110,8 @@
 #linux-g++:QMAKE_CXXFLAGS += -fcheck-memory-usage
 #linux-g++:QMAKE_LIBS += -lmpatrol -lbfd -liberty
 
+# auto_ptr deprecated in C++11, removed in C++17
+linux: QMAKE_CXXFLAGS += -std=c++03
 
 #----------------------------------------
 # Max OS X with XFree86 port, macx-g++
@@ -115,12 +121,11 @@
 ## macx-g++:QMAKE_CXXFLAGS += -D__GNU_LIBRARY__
 ## macx-g++:QMAKE_CXXFLAGS -= -fno-exceptions
 
-
 #----------------------------------------
 # Max OS X (macx-g++ for command line build)
 
 macx {
-   # Icon used to the application bundle
+   # Icon used for the application bundle
    ICON = xxdiff.icns
 
    # Special targets to quickly deploy a standalone mac package (just
@@ -149,13 +154,20 @@
    bison23src.depends = 
    YACCSOURCES = resParser_bison23.y
    QMAKE_YACCFLAGS_MANGLE = -p resParser -b resParser
+   resParser_lex_obj.target = resParser_lex.o
+   resParser_lex_obj.depends = bison23lnk
+
+   # "register" deprecated in C++11 but the MacOS flex still uses it in files it generates
+   QMAKE_LEXFLAGS += -Dregister=
 
    # "public" rule
    deploy.depends = $$dmg.target
 
-   QMAKE_EXTRA_TARGETS += macdeployqt dmg deploy bison23src bison23lnk
-   QMAKE_CXXFLAGS -= -O2
-   QMAKE_CXXFLAGS += -mdynamic-no-pic -O3 -ftracer -msse2 -msse3 -mssse3 -ftree-vectorize
+   QMAKE_EXTRA_TARGETS += macdeployqt dmg deploy bison23src bison23lnk resParser_lex_obj
+   QMAKE_CFLAGS_RELEASE   -= -O2
+   QMAKE_CXXFLAGS_RELEASE -= -O2
+   QMAKE_CFLAGS   += -mdynamic-no-pic -O3 -msse2 -msse3 -mssse3 -ftree-vectorize
+   QMAKE_CXXFLAGS += -mdynamic-no-pic -O3 -msse2 -msse3 -mssse3 -ftree-vectorize
 }
 
 #----------------------------------------
@@ -201,6 +213,7 @@
 	main.h \
 	overview.h \
 	resParser.h \
+	resParser_lex.h \
 	resources.h \
 	resources.inline.h \
 	accelUtil.h \
diff -urb ./tools/index.html ./tools/index.html
--- ./tools/index.html	2016-05-15 15:55:57.000000000 -0700
+++ ./tools/index.html	2019-06-26 09:20:52.000000000 -0700
@@ -3,14 +3,14 @@
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
 <head>
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
-<meta name="generator" content="Docutils 0.8.1: http://docutils.sourceforge.net/" />
+<meta name="generator" content="Docutils 0.12: http://docutils.sourceforge.net/" />
 <title>Version Control Tools and Other Utilities</title>
 <link rel="stylesheet" href="../style.css" type="text/css" />
 </head>
 <body>
 
 <div id="project-header">
-  <a href="/"><img src="/home/furius-logo-w.png" id="logo"></a>
+  <a href="http://furius.ca/"><img src="http://furius.ca/home/furius-logo-w.png" id="logo"></a>
   <div id="project-home"><a href="..">Project Home</a></div>
 </div>
 
--- src/xxdiff.pro.orig	2019-06-27 08:14:43.000000000 -0700
+++ src/xxdiff.pro	2019-06-27 08:48:54.000000000 -0700
@@ -145,29 +145,13 @@
    dmg.commands = @hdiutil create -ov -fs HFS+ -srcfolder $$BUNDLE -volname $$quote("xxdiff\\ $$VER") $$DMG
    dmg.depends = $$macdeployqt.target $(TARGET)
 
-   # Crappy crap to generate and use a specific bison source file that is compatible with bison 2.3 (the default on OSX)
-   bison23lnk.target = resParser_yacc.h
-   bison23lnk.commands = rm -f resParser_yacc.h resParser_yacc.cpp; ln -s resParser_bison23_yacc.cpp resParser_yacc.cpp; ln -s resParser_bison23_yacc.h resParser_yacc.h
-   bison23lnk.depends = bison23src resParser_bison23_yacc.h resParser_bison23.y
-   bison23src.target = resParser_bison23.y
-   bison23src.commands = perl -pe \'s/define api.pure/pure-parser/\' resParser.y > resParser_bison23.y
-   bison23src.depends = 
-   YACCSOURCES = resParser_bison23.y
-   QMAKE_YACCFLAGS_MANGLE = -p resParser -b resParser
-   resParser_lex_obj.target = resParser_lex.o
-   resParser_lex_obj.depends = bison23lnk
-
    # "register" deprecated in C++11 but the MacOS flex still uses it in files it generates
    QMAKE_LEXFLAGS += -Dregister=
 
    # "public" rule
    deploy.depends = $$dmg.target
 
-   QMAKE_EXTRA_TARGETS += macdeployqt dmg deploy bison23src bison23lnk resParser_lex_obj
-   QMAKE_CFLAGS_RELEASE   -= -O2
-   QMAKE_CXXFLAGS_RELEASE -= -O2
-   QMAKE_CFLAGS   += -mdynamic-no-pic -O3 -msse2 -msse3 -mssse3 -ftree-vectorize
-   QMAKE_CXXFLAGS += -mdynamic-no-pic -O3 -msse2 -msse3 -mssse3 -ftree-vectorize
+   QMAKE_EXTRA_TARGETS += macdeployqt dmg deploy
 }
 
 #----------------------------------------
--- src/cmdline.cpp.orig	2019-06-27 09:26:20.000000000 -0700
+++ src/cmdline.cpp	2019-06-27 09:31:37.000000000 -0700
@@ -202,8 +202,7 @@
      "Copies the input streams/files into temporary files to perform diffing. "
      "This is useful if you want to diff FIFOs."
    },
-// Hack for os x - programs are run with an argument line -psn_0_36306945
-   { "prompt-for-files", 'p', true, 'p',
+   { "prompt-for-files", 0, false, 'p',
      "If no files are specified on the command line, show a file dialog so that "
      "the user can select them. This option is ignored if any files are specified."
    },
