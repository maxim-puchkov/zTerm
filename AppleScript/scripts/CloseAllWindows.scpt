FasdUAS 1.101.10   ��   ��    k             l     ��  ��       Close All Windows     � 	 	 &     C l o s e   A l l   W i n d o w s   
  
 l     ��  ��     
  Services     �        S e r v i c e s      l     ��������  ��  ��        l     ��  ��    / )  Created by Maxim Puchkov on 2020-04-06.     �   R     C r e a t e d   b y   M a x i m   P u c h k o v   o n   2 0 2 0 - 0 4 - 0 6 .      l     ��  ��    < 6  Copyright � 2020 Maxim Puchkov. All rights reserved.     �   l     C o p y r i g h t   �   2 0 2 0   M a x i m   P u c h k o v .   A l l   r i g h t s   r e s e r v e d .      l     ��������  ��  ��        l     ��������  ��  ��         j     �� !�� 0 	ntf_title 	NTF_TITLE ! m      " " � # # 4 F i n d e r      c l o s e   a l l   w i n d o w s    $ % $ j    �� &�� 0 ntf_subtitle NTF_SUBTITLE & m     ' ' � ( (  S u c c e s s %  ) * ) l     ��������  ��  ��   *  + , + l     ��������  ��  ��   ,  - . - l     �� / 0��   /   Main Script Handler.     0 � 1 1 ,   M a i n   S c r i p t   H a n d l e r .   .  2 3 2 l     �� 4 5��   4 !  Close every Finder Window.    5 � 6 6 6   C l o s e   e v e r y   F i n d e r   W i n d o w . 3  7 8 7 i    	 9 : 9 I     ������
�� .aevtoappnull  �   � ****��  ��   : O     T ; < ; k    S = =  > ? > l   �� @ A��   @    Count all Finder windows.    A � B B 4   C o u n t   a l l   F i n d e r   w i n d o w s . ?  C D C r    	 E F E n    G H G 2   ��
�� 
cwin H  g     F o      ���� 0 all_windows   D  I J I r   
  K L K I  
 �� M��
�� .corecnte****       **** M o   
 ���� 0 all_windows  ��   L o      ���� 0 	n_windows   J  N O N l   ��������  ��  ��   O  P Q P l   �� R S��   R E ? Check number of openned windows. If no windows are open, then     S � T T ~   C h e c k   n u m b e r   o f   o p e n n e d   w i n d o w s .   I f   n o   w i n d o w s   a r e   o p e n ,   t h e n   Q  U V U l   �� W X��   W 8 2 	ERROR(1): display an error and terminate script.    X � Y Y d   	 E R R O R ( 1 ) :   d i s p l a y   a n   e r r o r   a n d   t e r m i n a t e   s c r i p t . V  Z [ Z Z    ; \ ]���� \ =     ^ _ ^ o    ���� 0 	n_windows   _ m    ����   ] k    7 ` `  a b a r     c d c m    ����  d o      ���� 0 	exit_code   b  e f e r    # g h g b    ! i j i b     k l k m     m m � n n  E r r o r   ( c o d e   l o    ���� 0 	exit_code   j m      o o � p p  ) h o      ���� 0 ntf_custom_subtitle   f  q r q r   $ ' s t s m   $ % u u � v v L A l l   F i n d e r   w i n d o w s   a r e   a l r e a d y   c l o s e d . t o      ���� 0 ntf_text   r  w x w n  ( 4 y z y I   ) 4�� {���� 0 ntf_full   {  | } | o   ) .���� 0 	ntf_title 	NTF_TITLE }  ~  ~ o   . /���� 0 ntf_custom_subtitle     ��� � o   / 0���� 0 ntf_text  ��  ��   z  f   ( ) x  ��� � L   5 7 � � o   5 6���� 0 	exit_code  ��  ��  ��   [  � � � l  < <��������  ��  ��   �  � � � l  < <�� � ���   � 4 . If there are open Finder windows, close them.    � � � � \   I f   t h e r e   a r e   o p e n   F i n d e r   w i n d o w s ,   c l o s e   t h e m . �  � � � I  < A�� ���
�� .coreclosnull���     obj  � o   < =���� 0 all_windows  ��   �  � � � l  B B��������  ��  ��   �  � � � l  B B�� � ���   � = 7 OK(0): display the number of closed windows and exit.     � � � � n   O K ( 0 ) :   d i s p l a y   t h e   n u m b e r   o f   c l o s e d   w i n d o w s   a n d   e x i t .   �  � � � r   B I � � � b   B G � � � b   B E � � � m   B C � � � � � ( S u c c e s s f u l l y   c l o s e d   � o   C D���� 0 	n_windows   � m   E F � � � � �     F i n d e r   w i n d o w s . � o      ���� 0 ntf_text   �  � � � n  J P � � � I   K P�� ����� 0 ntf_message   �  ��� � o   K L���� 0 ntf_text  ��  ��   �  f   J K �  ��� � L   Q S � � m   Q R����  ��   < m      � ��                                                                                  MACS  alis    @  Macintosh HD                   BD ����
Finder.app                                                     ����            ����  
 cu             CoreServices  )/:System:Library:CoreServices:Finder.app/    
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��   8  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � !  Full Notification Handler.    � � � � 6   F u l l   N o t i f i c a t i o n   H a n d l e r . �  � � � i  
  � � � I      �� ����� 0 ntf_full   �  � � � o      ���� 0 ntf_custom_title   �  � � � o      ���� 0 ntf_custom_subtitle   �  ��� � o      ���� 0 ntf_text  ��  ��   � I    	�� � �
�� .sysonotfnull��� ��� TEXT � o     ���� 0 ntf_text   � �� � �
�� 
appr � o    ���� 0 ntf_custom_title   � �� ���
�� 
subt � o    ���� 0 ntf_custom_subtitle  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � < 6 Notification Handler with default Title and Subtitle.    � � � � l   N o t i f i c a t i o n   H a n d l e r   w i t h   d e f a u l t   T i t l e   a n d   S u b t i t l e . �  ��� � i     � � � I      �� ����� 0 ntf_message   �  ��� � o      ���� 0 ntf_text  ��  ��   � I    �� � �
�� .sysonotfnull��� ��� TEXT � o     ���� 0 ntf_text   � �� � �
�� 
appr � o    ���� 0 	ntf_title 	NTF_TITLE � �� ���
�� 
subt � o    ���� 0 ntf_subtitle NTF_SUBTITLE��  ��       �� � " ' � � � ��� ��� ���   � 
���������������������� 0 	ntf_title 	NTF_TITLE�� 0 ntf_subtitle NTF_SUBTITLE
�� .aevtoappnull  �   � ****�� 0 ntf_full  �� 0 ntf_message  �� 0 all_windows  �� 0 	n_windows  �� 0 ntf_text  �� 0 	exit_code  �� 0 ntf_custom_subtitle   � �� :��~ � ��}
�� .aevtoappnull  �   � ****�  �~   �   �  ��|�{�z�y�x m o�w u�v�u�t � ��s
�| 
cwin�{ 0 all_windows  
�z .corecnte****       ****�y 0 	n_windows  �x 0 	exit_code  �w 0 ntf_custom_subtitle  �v 0 ntf_text  �u 0 ntf_full  
�t .coreclosnull���     obj �s 0 ntf_message  �} U� Q*�-E�O�j E�O�j  $kE�O��%�%E�O�E�O)b   ��m+ O�Y hO�j O��%�%E�O)�k+ OjU � �r ��q�p � ��o�r 0 ntf_full  �q �n ��n  �  �m�l�k�m 0 ntf_custom_title  �l 0 ntf_custom_subtitle  �k 0 ntf_text  �p   � �j�i�h�j 0 ntf_custom_title  �i 0 ntf_custom_subtitle  �h 0 ntf_text   � �g�f�e�d
�g 
appr
�f 
subt�e 
�d .sysonotfnull��� ��� TEXT�o 
����  � �c ��b�a � ��`�c 0 ntf_message  �b �_ ��_  �  �^�^ 0 ntf_text  �a   � �]�] 0 ntf_text   � �\�[�Z�Y
�\ 
appr
�[ 
subt�Z 
�Y .sysonotfnull��� ��� TEXT�` ��b   �b  �  � �X ��X  �   � � �  � �  ��W�V�U
�W 
brow�V
�U kfrmID   �  � �  ��T�S�R
�T 
brow�S
�R kfrmID  ��  � � � � J S u c c e s s f u l l y   c l o s e d   2   F i n d e r   w i n d o w s .��  � � � �  E r r o r   ( c o d e   1 ) ascr  ��ޭ