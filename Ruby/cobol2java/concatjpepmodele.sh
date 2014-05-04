#!/bin/bash
#
#ce script concatene deux images, les grossisant deux fois. 
#il ajoute un titre de taille 8 

montage  -geometry +2+2 -title "VFPB9309" -pointsize 24  VFPB9309.jpg ReporterGcSurGbSansBg.jpg  ReporterBgSurGbSansGc.jpg ReporterBgEgalGcSurGb.jpg finaliserVfpb9309.jpg    vfpb9309.jpg
