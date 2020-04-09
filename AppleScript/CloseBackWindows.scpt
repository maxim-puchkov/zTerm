FasdUAS 1.101.10   ��   ��    k             l     ��  ��       Close Back Windows     � 	 	 (     C l o s e   B a c k   W i n d o w s   
  
 l     ��  ��       Z-Terminal: Finder     �   (     Z - T e r m i n a l :   F i n d e r      l     ��������  ��  ��        l     ��  ��    / )  Created by Maxim Puchkov on 2020-04-06.     �   R     C r e a t e d   b y   M a x i m   P u c h k o v   o n   2 0 2 0 - 0 4 - 0 6 .      l     ��  ��    < 6  Copyright � 2020 Maxim Puchkov. All rights reserved.     �   l     C o p y r i g h t   �   2 0 2 0   M a x i m   P u c h k o v .   A l l   r i g h t s   r e s e r v e d .      l     ��������  ��  ��        l     ��������  ��  ��         j     �� !�� 0 	ntf_title 	NTF_TITLE ! m      " " � # # B F i n d e r      c l o s e   b a c k g r o u n d   w i n d o w s    $ % $ j    �� &�� 0 ntf_subtitle NTF_SUBTITLE & m     ' ' � ( (  S u c c e s s %  ) * ) l     ��������  ��  ��   *  + , + l     ��������  ��  ��   ,  - . - l     �� / 0��   /   Main Script Handler:    0 � 1 1 *   M a i n   S c r i p t   H a n d l e r : .  2 3 2 l     �� 4 5��   4 2 , Close only the *background* Finder windows.    5 � 6 6 X   C l o s e   o n l y   t h e   * b a c k g r o u n d *   F i n d e r   w i n d o w s . 3  7 8 7 i    	 9 : 9 I     ������
�� .aevtoappnull  �   � ****��  ��   : O     � ; < ; k    � = =  > ? > l   �� @ A��   @    Count all Finder windows.    A � B B 4   C o u n t   a l l   F i n d e r   w i n d o w s . ?  C D C r    	 E F E n    G H G 2   ��
�� 
cwin H  g     F o      ���� 0 all_windows   D  I J I r   
  K L K I  
 �� M��
�� .corecnte****       **** M o   
 ���� 0 all_windows  ��   L o      ���� 0 	n_windows   J  N O N r     P Q P n     R S R 1    ��
�� 
ID   S n    T U T 4    �� V
�� 
cwin V m    ����  U  g     Q o      ���� 0 front_id   O  W X W l   ��������  ��  ��   X  Y Z Y l   �� [ \��   [ Q K Check number of openned windows. If none or only one window is open, then     \ � ] ] �   C h e c k   n u m b e r   o f   o p e n n e d   w i n d o w s .   I f   n o n e   o r   o n l y   o n e   w i n d o w   i s   o p e n ,   t h e n   Z  ^ _ ^ l   �� ` a��   ` 8 2 	ERROR(1): display an error and terminate script.    a � b b d   	 E R R O R ( 1 ) :   d i s p l a y   a n   e r r o r   a n d   t e r m i n a t e   s c r i p t . _  c d c Z    D e f���� e B     g h g o    ���� 0 	n_windows   h m    ����  f k   ! @ i i  j k j r   ! $ l m l m   ! "����  m o      ���� 0 	exit_code   k  n o n r   % , p q p b   % * r s r b   % ( t u t m   % & v v � w w  E r r o r   ( c o d e   u o   & '���� 0 	exit_code   s m   ( ) x x � y y  ) q o      ���� 0 ntf_custom_subtitle   o  z { z r   - 0 | } | m   - . ~ ~ �   b A l l   b a c k g r o u n d   F i n d e r   w i n d o w s   a r e   a l r e a d y   c l o s e d . } o      ���� 0 ntf_text   {  � � � n  1 = � � � I   2 =�� ����� 0 ntf_full   �  � � � o   2 7���� 0 	ntf_title 	NTF_TITLE �  � � � o   7 8���� 0 ntf_custom_subtitle   �  ��� � o   8 9���� 0 ntf_text  ��  ��   �  f   1 2 �  ��� � L   > @ � � o   > ?���� 0 	exit_code  ��  ��  ��   d  � � � l  E E��������  ��  ��   �  � � � l  E E��������  ��  ��   �  � � � r   E H � � � o   E F���� 0 	n_windows   � o      ���� 0 current_index   �  � � � W   I l � � � k   Q g � �  � � � r   Q Y � � � n   Q U � � � 4   R U�� �
�� 
cobj � o   S T���� 0 current_index   � o   Q R���� 0 all_windows   � o      ���� 0 w   �  � � � I  Z a�� ���
�� .coreclosnull���     obj  � o   Z ]���� 0 w  ��   �  ��� � r   b g � � � \   b e � � � o   b c���� 0 current_index   � m   c d����  � o      ���� 0 current_index  ��   � =   M P � � � o   M N���� 0 current_index   � m   N O����  �  � � � L   m o � � o   m n���� 0 current_index   �  � � � l  p p�� � ���   �  - --(#     � � � �  -   - - ( #   �  � � � l  p p�� � ���   �  		repeat with x in     � � � � & 	 	 r e p e a t   w i t h   x   i n   �  � � � l  p p�� � ���   � ! 			return w is front window    � � � � 6 	 	 	 r e t u r n   w   i s   f r o n t   w i n d o w �  � � � l  p p�� � ���   �  			set w_id to (id of w)    � � � � 0 	 	 	 s e t   w _ i d   t o   ( i d   o f   w ) �  � � � l  p p�� � ���   � ' !			if (w_id is not front_id) then    � � � � B 	 	 	 i f   ( w _ i d   i s   n o t   f r o n t _ i d )   t h e n �  � � � l  p p�� � ���   �  				close w    � � � �  	 	 	 	 c l o s e   w �  � � � l  p p�� � ���   �  				end if    � � � �  	 	 	 e n d   i f �  � � � l  p p�� � ���   � ' !			if (w = its front window) then    � � � � B 	 	 	 i f   ( w   =   i t s   f r o n t   w i n d o w )   t h e n �  � � � l  p p�� � ���   �  				return {w, 2}    � � � � " 	 	 	 	 r e t u r n   { w ,   2 } �  � � � l  p p�� � ���   �  				end if    � � � �  	 	 	 e n d   i f �  � � � l  p p�� � ���   � Z T			return {w, properties of w, "==========12345---", properties of its front window}    � � � � � 	 	 	 r e t u r n   { w ,   p r o p e r t i e s   o f   w ,   " = = = = = = = = = = 1 2 3 4 5 - - - " ,   p r o p e r t i e s   o f   i t s   f r o n t   w i n d o w } �  � � � l  p p�� � ���   �  		end repeat    � � � �  	 	 e n d   r e p e a t �  � � � l  p p�� � ���   �  )    � � � �  ) �  � � � l  p p�� � ���   � 4 . If there are open Finder windows, close them.    � � � � \   I f   t h e r e   a r e   o p e n   F i n d e r   w i n d o w s ,   c l o s e   t h e m . �  � � � l  p p�� � ���   � / ) set back_windows to its windows 2 thru 3    � � � � R   s e t   b a c k _ w i n d o w s   t o   i t s   w i n d o w s   2   t h r u   3 �  � � � I  p w�� ���
�� .coreclosnull���     obj  � o   p s���� 0 back_windows  ��   �  � � � l  x x��������  ��  ��   �  � � � l  x x�� � ��   � = 7 OK(0): display the number of closed windows and exit.      � n   O K ( 0 ) :   d i s p l a y   t h e   n u m b e r   o f   c l o s e d   w i n d o w s   a n d   e x i t .   �  r   x � b   x � b   x }	 m   x {

 � ( S u c c e s s f u l l y   c l o s e d  	 o   { |���� 0 	n_windows   m   } � � 6   b a c k g r o u n d   F i n d e r   w i n d o w s . o      ���� 0 ntf_text    n  � � I   � ������� 0 ntf_message   �� o   � ����� 0 ntf_text  ��  ��    f   � � �� L   � � m   � �����  ��   < m     �                                                                                  MACS  alis    @  Macintosh HD                   BD ����
Finder.app                                                     ����            ����  
 cu             CoreServices  )/:System:Library:CoreServices:Finder.app/    
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��   8  l     ��������  ��  ��    l     ��������  ��  ��    l     ����   !  Full Notification Handler.    � 6   F u l l   N o t i f i c a t i o n   H a n d l e r .  !  i  
 "#" I      ��$���� 0 ntf_full  $ %&% o      ���� 0 ntf_custom_title  & '(' o      ���� 0 ntf_custom_subtitle  ( )��) o      ���� 0 ntf_text  ��  ��  # I    	��*+
�� .sysonotfnull��� ��� TEXT* o     ���� 0 ntf_text  + ��,-
�� 
appr, o    �� 0 ntf_custom_title  - �~.�}
�~ 
subt. o    �|�| 0 ntf_custom_subtitle  �}  ! /0/ l     �{�z�y�{  �z  �y  0 121 l     �x�w�v�x  �w  �v  2 343 l     �u56�u  5 < 6 Notification Handler with default Title and Subtitle.   6 �77 l   N o t i f i c a t i o n   H a n d l e r   w i t h   d e f a u l t   T i t l e   a n d   S u b t i t l e .4 8�t8 i    9:9 I      �s;�r�s 0 ntf_message  ; <�q< o      �p�p 0 ntf_text  �q  �r  : I    �o=>
�o .sysonotfnull��� ��� TEXT= o     �n�n 0 ntf_text  > �m?@
�m 
appr? o    �l�l 0 	ntf_title 	NTF_TITLE@ �kA�j
�k 
subtA o    �i�i 0 ntf_subtitle NTF_SUBTITLE�j  �t       �hB " 'CDE�h  B �g�f�e�d�c�g 0 	ntf_title 	NTF_TITLE�f 0 ntf_subtitle NTF_SUBTITLE
�e .aevtoappnull  �   � ****�d 0 ntf_full  �c 0 ntf_message  C �b :�a�`FG�_
�b .aevtoappnull  �   � ****�a  �`  F  G �^�]�\�[�Z�Y�X v x�W ~�V�U�T�S�R�Q�P
�O
�^ 
cwin�] 0 all_windows  
�\ .corecnte****       ****�[ 0 	n_windows  
�Z 
ID  �Y 0 front_id  �X 0 	exit_code  �W 0 ntf_custom_subtitle  �V 0 ntf_text  �U 0 ntf_full  �T 0 current_index  
�S 
cobj�R 0 w  
�Q .coreclosnull���     obj �P 0 back_windows  �O 0 ntf_message  �_ �� �*�-E�O�j E�O*�k/�,E�O�k $kE�O��%�%E�O�E�O)b   ��m+ O�Y hO�E�O "h�k ���/E` O_ j O�kE�[OY��O�O_ j Oa �%a %E�O)�k+ OjUD �N#�M�LHI�K�N 0 ntf_full  �M �JJ�J J  �I�H�G�I 0 ntf_custom_title  �H 0 ntf_custom_subtitle  �G 0 ntf_text  �L  H �F�E�D�F 0 ntf_custom_title  �E 0 ntf_custom_subtitle  �D 0 ntf_text  I �C�B�A�@
�C 
appr
�B 
subt�A 
�@ .sysonotfnull��� ��� TEXT�K 
���� E �?:�>�=KL�<�? 0 ntf_message  �> �;M�; M  �:�: 0 ntf_text  �=  K �9�9 0 ntf_text  L �8�7�6�5
�8 
appr
�7 
subt�6 
�5 .sysonotfnull��� ��� TEXT�< ��b   �b  �  ascr  ��ޭ