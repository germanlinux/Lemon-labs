=begin
** Form generated from reading ui file 'rytomtom.ui'
**
** Created: mer. sept. 7 05:00:43 2011
**      by: Qt User Interface Compiler version 4.7.0
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

class Ui_MainWindow
    attr_reader :centralwidget
    attr_reader :tabWidget
    attr_reader :tab
    attr_reader :label_2
    attr_reader :l_info
    attr_reader :verticalLayoutWidget
    attr_reader :verticalLayout
    attr_reader :label_7
    attr_reader :verticalLayoutWidget_2
    attr_reader :verticalLayout_2
    attr_reader :line
    attr_reader :tab_2
    attr_reader :lineEdit
    attr_reader :label
    attr_reader :pushButton
    attr_reader :frame
    attr_reader :l_dsave
    attr_reader :label_3
    attr_reader :label_5
    attr_reader :label_6
    attr_reader :label_4
    attr_reader :pb_save
    attr_reader :exit
    attr_reader :statusbar

    def setupUi(mainWindow)
    if mainWindow.objectName.nil?
        mainWindow.objectName = "mainWindow"
    end
    mainWindow.resize(945, 600)
    @centralwidget = Qt::Widget.new(mainWindow)
    @centralwidget.objectName = "centralwidget"
    @centralwidget.enabled = false
    @tabWidget = Qt::TabWidget.new(@centralwidget)
    @tabWidget.objectName = "tabWidget"
    @tabWidget.geometry = Qt::Rect.new(20, 20, 801, 421)
    @tab = Qt::Widget.new()
    @tab.objectName = "tab"
    @tab.enabled = false
    @label_2 = Qt::Label.new(@tab)
    @label_2.objectName = "label_2"
    @label_2.geometry = Qt::Rect.new(380, 360, 130, 20)
    @label_2.frameShape = Qt::Frame::Panel
    @label_2.frameShadow = Qt::Frame::Sunken
    @l_info = Qt::Label.new(@tab)
    @l_info.objectName = "l_info"
    @l_info.geometry = Qt::Rect.new(20, 30, 631, 17)
    @l_info.frameShape = Qt::Frame::StyledPanel
    @l_info.frameShadow = Qt::Frame::Raised
    @verticalLayoutWidget = Qt::Widget.new(@tab)
    @verticalLayoutWidget.objectName = "verticalLayoutWidget"
    @verticalLayoutWidget.geometry = Qt::Rect.new(30, 70, 181, 80)
    @verticalLayout = Qt::VBoxLayout.new(@verticalLayoutWidget)
    @verticalLayout.objectName = "verticalLayout"
    @verticalLayout.setContentsMargins(0, 0, 0, 0)
    @label_7 = Qt::Label.new(@verticalLayoutWidget)
    @label_7.objectName = "label_7"

    @verticalLayout.addWidget(@label_7)

    @verticalLayoutWidget_2 = Qt::Widget.new(@tab)
    @verticalLayoutWidget_2.objectName = "verticalLayoutWidget_2"
    @verticalLayoutWidget_2.geometry = Qt::Rect.new(30, 180, 341, 80)
    @verticalLayout_2 = Qt::VBoxLayout.new(@verticalLayoutWidget_2)
    @verticalLayout_2.objectName = "verticalLayout_2"
    @verticalLayout_2.setContentsMargins(0, 0, 0, 0)
    @line = Qt::Frame.new(@tab)
    @line.objectName = "line"
    @line.geometry = Qt::Rect.new(20, 160, 351, 16)
    @line.setFrameShape(Qt::Frame::HLine)
    @line.setFrameShadow(Qt::Frame::Sunken)
    @tabWidget.addTab(@tab, Qt::Application.translate("MainWindow", "Informations", nil, Qt::Application::UnicodeUTF8))
    @tab_2 = Qt::Widget.new()
    @tab_2.objectName = "tab_2"
    @lineEdit = Qt::LineEdit.new(@tab_2)
    @lineEdit.objectName = "lineEdit"
    @lineEdit.geometry = Qt::Rect.new(210, 49, 221, 31)
    @label = Qt::Label.new(@tab_2)
    @label.objectName = "label"
    @label.geometry = Qt::Rect.new(10, 50, 201, 17)
    @pushButton = Qt::PushButton.new(@tab_2)
    @pushButton.objectName = "pushButton"
    @pushButton.enabled = false
    @pushButton.geometry = Qt::Rect.new(450, 50, 51, 27)
    @frame = Qt::Frame.new(@tab_2)
    @frame.objectName = "frame"
    @frame.geometry = Qt::Rect.new(530, 30, 241, 141)
    @frame.frameShape = Qt::Frame::Box
    @frame.frameShadow = Qt::Frame::Sunken
    @l_dsave = Qt::Label.new(@frame)
    @l_dsave.objectName = "l_dsave"
    @l_dsave.geometry = Qt::Rect.new(10, 20, 141, 17)
    @label_3 = Qt::Label.new(@frame)
    @label_3.objectName = "label_3"
    @label_3.geometry = Qt::Rect.new(10, 50, 141, 17)
    @label_5 = Qt::Label.new(@frame)
    @label_5.objectName = "label_5"
    @label_5.geometry = Qt::Rect.new(10, 80, 141, 17)
    @label_6 = Qt::Label.new(@frame)
    @label_6.objectName = "label_6"
    @label_6.geometry = Qt::Rect.new(10, 110, 221, 17)
    @label_4 = Qt::Label.new(@tab_2)
    @label_4.objectName = "label_4"
    @label_4.geometry = Qt::Rect.new(560, 10, 70, 17)
    @pb_save = Qt::PushButton.new(@tab_2)
    @pb_save.objectName = "pb_save"
    @pb_save.enabled = false
    @pb_save.geometry = Qt::Rect.new(300, 340, 98, 27)
    @tabWidget.addTab(@tab_2, Qt::Application.translate("MainWindow", "Parametres", nil, Qt::Application::UnicodeUTF8))
    @exit = Qt::CommandLinkButton.new(@centralwidget)
    @exit.objectName = "exit"
    @exit.enabled = false
    @exit.geometry = Qt::Rect.new(830, 60, 187, 41)
    @exit.autoFillBackground = true
    mainWindow.centralWidget = @centralwidget
    @statusbar = Qt::StatusBar.new(mainWindow)
    @statusbar.objectName = "statusbar"
    mainWindow.statusBar = @statusbar

    retranslateUi(mainWindow)

    @tabWidget.setCurrentIndex(0)


    Qt::MetaObject.connectSlotsByName(mainWindow)
    end # setupUi

    def setup_ui(mainWindow)
        setupUi(mainWindow)
    end

    def retranslateUi(mainWindow)
    mainWindow.windowTitle = Qt::Application.translate("MainWindow", "MainWindow", nil, Qt::Application::UnicodeUTF8)
    @label_2.text = Qt::Application.translate("MainWindow", "RyTomTom: v0.0", nil, Qt::Application::UnicodeUTF8)
    @l_info.text = Qt::Application.translate("MainWindow", "TextLabel", nil, Qt::Application::UnicodeUTF8)
    @label_7.text = Qt::Application.translate("MainWindow", "TextLabel", nil, Qt::Application::UnicodeUTF8)
    @tabWidget.setTabText(@tabWidget.indexOf(@tab), Qt::Application.translate("MainWindow", "Informations", nil, Qt::Application::UnicodeUTF8))
    @label.text = Qt::Application.translate("MainWindow", "R\303\251pertoire de  la sauvegarde:", nil, Qt::Application::UnicodeUTF8)
    @pushButton.text = Qt::Application.translate("MainWindow", "OK", nil, Qt::Application::UnicodeUTF8)
    @l_dsave.text = Qt::Application.translate("MainWindow", "TextLabel", nil, Qt::Application::UnicodeUTF8)
    @label_3.text = Qt::Application.translate("MainWindow", "TextLabel", nil, Qt::Application::UnicodeUTF8)
    @label_5.text = Qt::Application.translate("MainWindow", "TextLabel", nil, Qt::Application::UnicodeUTF8)
    @label_6.text = Qt::Application.translate("MainWindow", "TextLabel", nil, Qt::Application::UnicodeUTF8)
    @label_4.text = Qt::Application.translate("MainWindow", "STATUT", nil, Qt::Application::UnicodeUTF8)
    @pb_save.text = Qt::Application.translate("MainWindow", "Enregistrer", nil, Qt::Application::UnicodeUTF8)
    @tabWidget.setTabText(@tabWidget.indexOf(@tab_2), Qt::Application.translate("MainWindow", "Parametres", nil, Qt::Application::UnicodeUTF8))
    @exit.text = Qt::Application.translate("MainWindow", "Exit", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(mainWindow)
        retranslateUi(mainWindow)
    end

end

module Ui
    class MainWindow < Ui_MainWindow
    end
end  # module Ui

