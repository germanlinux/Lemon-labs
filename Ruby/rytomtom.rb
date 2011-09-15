$: <<"./"
require 'rubygems'
require 'rytomtom_ui'
require 'Qt4'
require 'metadata' 
require 'utiltomtom'
# We inherit from Qt:Dialog as it gives us access to User Interface
# functionality such as connecting slots and signals
class RyTOMTOM < Qt::MainWindow
    slots 'texte_saisi()','sauve()','exit()' 
    signals 'clicked()'

    attr_accessor :meta
    # We are then free to put our own code into this class without fear
    # of it being overwritten. Here we add a initialize function which
    # can be used to customise how the form looks on startup. The method
    # initialize() is a constructor in Ruby
 
    def initialize(parent = nil)
 
       # Widgets in Qt can optionally be children of other widgets.
       # That's why we accept parent as a parameter
 
       # This super call causes the constructor of the base class (Qt::Widget)
       # to be called, shepherding on the parent argument
 
       super(parent)
 
       # The Dashboard class we  are in holds presentation logic and exists
       # to 'manage' the dialog widget we created in Qt Designer earlier.
       # An instance of this dialog widget is created and stored in @ui variable
 
       @ui = Ui::MainWindow.new
 
       # Calling setup_ui causes the dialog widget to be initialised with the
       # defaults you may have specified in Qt Designer. For example, it 
       # - populates the 'First Line' and 'Second Line' items in the List Widget
       # - sets the drag drop mode to 'Internal'
       # - and much much more. Peer into the dashboard_ui.rb if you want to the
       #   full gory details
 
       @ui.setup_ui(self)
      ## @ui.lineEdit.connect(self,SIGNAL :editingFinished)(),self, SLOT("texte_saisi('eric')"))
        connect(@ui.pushButton,SIGNAL('clicked()'),self, SLOT("texte_saisi()"))
        connect(@ui.pb_save,SIGNAL('clicked()'),self, SLOT("sauve()"))
       connect(@ui.exit,SIGNAL('clicked()'),self, SLOT("exit()"))
    end
  def starter(metadata)
  ## initilisations diverses
     @ui.pushButton.enabled= true
     @ui.tab.enabled = true
     @ui.centralwidget.enabled= true
     @ui.exit.enabled= true
   @meta= metadata
   directory= metadata.directory_save
  @ui.lineEdit.setText(directory)   
    if @ui.lineEdit.text() != 'A COMPLETER'  then 
      @ui.tabWidget.setCurrentIndex(0)
      @ui.l_dsave.text='Existe'
      formate(@meta)
  directory = @meta.directory_save       
  @ui.l_info.text=chargeinfo(directory)
        @ui.label_7.text = "Cartes disponibles:"
     
       charge_map (directory)
       charge_application(directory)
   else 
    @ui.tabWidget.setCurrentIndex(1)
    @ui.l_dsave.text='A completer'  
     end
  end 
  def texte_saisi
     my_twt= @ui.lineEdit.text()
     if my_twt !~ /\/$/ then my_twt+='/' end
  ### verifie  si le répertoire existe
     if  (File.exist?(my_twt) and File.ftype(my_twt) =='directory') then  
     @ui.lineEdit.setText(my_twt)
     @ui.l_dsave.text='Existe'
     @meta.metadata['directory_save'] = my_twt 
     @ui.pb_save.enabled= true
     else 
       @ui.l_dsave.text='Erreur'
    end
  end
  def exit
   Qt::Application.instance.quit
  end

  def sauve
    a=Sauvegarde.new(@ui.lineEdit.text())
    a.analyse
    @meta.metadata['content']= a.contenu 
    @meta.metadata['cpdirectory']= a.directory
    @meta.metadata['cpfile']= a.file
    @meta.metadata['date']=Time.now
    formate(@meta)
    @meta.write 
    @ui.pb_save.enabled= false

  end
 def  formate(meta)
    @ui.label_3.text= "reperoires:#{meta.get_cpdir}"
    @ui.label_5.text= "fichiers:#{meta.get_cpfile}"
    @ui.label_6.text= "Date: #{meta.get_date}"
 end 
 def chargeinfo(ds)
    info= InfoTOMTOM.new("#{ds}/TomTom-Cfg/release.nfo")
    "Materiel: #{info.get_info_produit}"
 end
 def charge_map(ds)
      info= InfoTOMTOM.new("#{ds}/TomTom-Cfg/release.nfo")
      maps= info.get_info_map
     
      cp=1
      maps.each do |amap|  
        tmp_ui = Qt::Label.new(@ui.verticalLayoutWidget)    
        tmp_ui.objectName="label_m#{cp}"
        @ui.verticalLayout.addWidget(tmp_ui)    
        tmp_ui.text  = "(#{amap[0]}):#{amap[1]}"
        cp=cp+1 
     end

   
 end
 def charge_application(ds)
      info= InfoTOMTOM.new("#{ds}/TomTom-Cfg/release.nfo")
      maps= info.get_info_application
        tmp_ui = Qt::Label.new(@ui.verticalLayoutWidget)    
      #  tmp_ui.objectName="label_m#{cp}"
       @ui.verticalLayout_2.addWidget(tmp_ui)    
           tmp_ui.text= "#{maps[0][0]}:#{maps[0][1]}"
        tmp_ui = Qt::Label.new(@ui.verticalLayoutWidget)    
      #  tmp_ui.objectName="label_m#{cp}"
       @ui.verticalLayout_2.addWidget(tmp_ui)    
      tmp_ui.text= "#{maps[1][0]}:#{maps[1][1]}"
     
 end       
 
end
