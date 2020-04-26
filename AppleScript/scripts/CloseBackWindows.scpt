FasdUAS 1.101.10   ��   ��    k             l     ��  ��       Close Back Windows     � 	 	 (     C l o s e   B a c k   W i n d o w s   
  
 l     ��  ��     
  Services     �        S e r v i c e s      l     ��������  ��  ��        l     ��  ��    / )  Created by Maxim Puchkov on 2020-04-06.     �   R     C r e a t e d   b y   M a x i m   P u c h k o v   o n   2 0 2 0 - 0 4 - 0 6 .      l     ��  ��    < 6  Copyright � 2020 Maxim Puchkov. All rights reserved.     �   l     C o p y r i g h t   �   2 0 2 0   M a x i m   P u c h k o v .   A l l   r i g h t s   r e s e r v e d .      l     ��������  ��  ��        l     ��������  ��  ��         j     �� !�� 0 	ntf_title 	NTF_TITLE ! m      " " � # # B F i n d e r      c l o s e   b a c k g r o u n d   w i n d o w s    $ % $ j    �� &�� 0 ntf_subtitle NTF_SUBTITLE & m     ' ' � ( (  S u c c e s s %  ) * ) l     ��������  ��  ��   *  + , + l     ��������  ��  ��   ,  - . - l     �� / 0��   /   Main Script Handler:    0 � 1 1 *   M a i n   S c r i p t   H a n d l e r : .  2 3 2 l     �� 4 5��   4 0 * Close only the background Finder windows.    5 � 6 6 T   C l o s e   o n l y   t h e   b a c k g r o u n d   F i n d e r   w i n d o w s . 3  7 8 7 i    	 9 : 9 I     ������
�� .aevtoappnull  �   � ****��  ��   : O     | ; < ; k    { = =  > ? > l   �� @ A��   @    Count all Finder windows.    A � B B 4   C o u n t   a l l   F i n d e r   w i n d o w s . ?  C D C r    	 E F E n    G H G 2   ��
�� 
cwin H  g     F o      ���� 0 all_windows   D  I J I r   
  K L K I  
 �� M��
�� .corecnte****       **** M o   
 ���� 0 all_windows  ��   L o      ���� 0 	n_windows   J  N O N l   ��������  ��  ��   O  P Q P l   �� R S��   R Q K Check number of openned windows. If none or only one window is open, then     S � T T �   C h e c k   n u m b e r   o f   o p e n n e d   w i n d o w s .   I f   n o n e   o r   o n l y   o n e   w i n d o w   i s   o p e n ,   t h e n   Q  U V U l   �� W X��   W 8 2 	ERROR(1): display an error and terminate script.    X � Y Y d   	 E R R O R ( 1 ) :   d i s p l a y   a n   e r r o r   a n d   t e r m i n a t e   s c r i p t . V  Z [ Z Z    ; \ ]���� \ B     ^ _ ^ o    ���� 0 	n_windows   _ m    ����  ] k    7 ` `  a b a r     c d c m    ����  d o      ���� 0 	exit_code   b  e f e r    # g h g b    ! i j i b     k l k m     m m � n n  E r r o r   ( c o d e   l o    ���� 0 	exit_code   j m      o o � p p  ) h o      ���� 0 ntf_custom_subtitle   f  q r q r   $ ' s t s m   $ % u u � v v b A l l   b a c k g r o u n d   F i n d e r   w i n d o w s   a r e   a l r e a d y   c l o s e d . t o      ���� 0 ntf_text   r  w x w n  ( 4 y z y I   ) 4�� {���� 0 ntf_full   {  | } | o   ) .���� 0 	ntf_title 	NTF_TITLE }  ~  ~ o   . /���� 0 ntf_custom_subtitle     ��� � o   / 0���� 0 ntf_text  ��  ��   z  f   ( ) x  ��� � L   5 7 � � o   5 6���� 0 	exit_code  ��  ��  ��   [  � � � l  < <��������  ��  ��   �  � � � l  < <�� � ���   � %  Close all windows except front    � � � � >   C l o s e   a l l   w i n d o w s   e x c e p t   f r o n t �  � � � r   < ? � � � o   < =���� 0 	n_windows   � o      ���� 0 current_index   �  � � � W   @ _ � � � k   H Z � �  � � � r   H N � � � n   H L � � � 4   I L�� �
�� 
cobj � o   J K���� 0 current_index   � o   H I���� 0 all_windows   � o      ���� 0 w   �  � � � I  O T�� ���
�� .coreclosnull���     obj  � o   O P���� 0 w  ��   �  ��� � r   U Z � � � \   U X � � � o   U V���� 0 current_index   � m   V W����  � o      ���� 0 current_index  ��   � =   D G � � � o   D E���� 0 current_index   � m   E F����  �  � � � l  ` `��������  ��  ��   �  � � � l  ` `�� � ���   � 4 . If there are open Finder windows, close them.    � � � � \   I f   t h e r e   a r e   o p e n   F i n d e r   w i n d o w s ,   c l o s e   t h e m . �  � � � l  ` `�� � ���   � / ) set back_windows to its windows 2 thru 3    � � � � R   s e t   b a c k _ w i n d o w s   t o   i t s   w i n d o w s   2   t h r u   3 �  � � � l  ` `�� � ���   �   close back_windows    � � � � &   c l o s e   b a c k _ w i n d o w s �  � � � l  ` `��������  ��  ��   �  � � � l  ` `�� � ���   � = 7 OK(0): display the number of closed windows and exit.     � � � � n   O K ( 0 ) :   d i s p l a y   t h e   n u m b e r   o f   c l o s e d   w i n d o w s   a n d   e x i t .   �  � � � r   ` k � � � b   ` i � � � b   ` e � � � m   ` c � � � � � ( S u c c e s s f u l l y   c l o s e d   � o   c d���� 0 	n_windows   � m   e h � � � � � 6   b a c k g r o u n d   F i n d e r   w i n d o w s . � o      ���� 0 ntf_text   �  � � � n  l r � � � I   m r�� ����� 0 ntf_message   �  ��� � o   m n���� 0 ntf_text  ��  ��   �  f   l m �  � � � I  s x�� ���
�� .ascrcmnt****      � **** � o   s t���� 0 ntf_text  ��   �  ��� � L   y { � � m   y z����  ��   < m      � ��                                                                                  MACS  alis    @  Macintosh HD                   BD ����
Finder.app                                                     ����            ����  
 cu             CoreServices  )/:System:Library:CoreServices:Finder.app/    
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��   8  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � !  Full Notification Handler.    � � � � 6   F u l l   N o t i f i c a t i o n   H a n d l e r . �  � � � i  
  � � � I      �� ����� 0 ntf_full   �  � � � o      ���� 0 ntf_custom_title   �  � � � o      ���� 0 ntf_custom_subtitle   �  ��� � o      ���� 0 ntf_text  ��  ��   � I    	�� � �
�� .sysonotfnull��� ��� TEXT � o     ���� 0 ntf_text   � �� � �
�� 
appr � o    ���� 0 ntf_custom_title   � �� ���
�� 
subt � o    ���� 0 ntf_custom_subtitle  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � < 6 Notification Handler with default Title and Subtitle.    � � � � l   N o t i f i c a t i o n   H a n d l e r   w i t h   d e f a u l t   T i t l e   a n d   S u b t i t l e . �  ��� � i     � � � I      �� ����� 0 ntf_message   �  ��� � o      ���� 0 ntf_text  ��  ��   � I    � � �
� .sysonotfnull��� ��� TEXT � o     �~�~ 0 ntf_text   � �} � �
�} 
appr � o    �|�| 0 	ntf_title 	NTF_TITLE � �{ ��z
�{ 
subt � o    �y�y 0 ntf_subtitle NTF_SUBTITLE�z  ��       �x � " ' �w�v�x   � 
�u�t�s�r�q�p�o�n�m�l�u 0 	ntf_title 	NTF_TITLE�t 0 ntf_subtitle NTF_SUBTITLE
�s .aevtoappnull  �   � ****�r 0 ntf_full  �q 0 ntf_message  �p 0 all_windows  �o 0 	n_windows  �n 0 current_index  �m 0 w  �l 0 ntf_text    �k :�j�i�h
�k .aevtoappnull  �   � ****�j  �i      ��g�f�e�d�c m o�b u�a�`�_�^�]�\ � ��[�Z
�g 
cwin�f 0 all_windows  
�e .corecnte****       ****�d 0 	n_windows  �c 0 	exit_code  �b 0 ntf_custom_subtitle  �a 0 ntf_text  �` 0 ntf_full  �_ 0 current_index  
�^ 
cobj�] 0 w  
�\ .coreclosnull���     obj �[ 0 ntf_message  
�Z .ascrcmnt****      � ****�h }� y*�-E�O�j E�O�k $kE�O��%�%E�O�E�O)b   ��m+ O�Y hO�E�O h�k ���/E�O�j O�kE�[OY��Oa �%a %E�O)�k+ O�j OjU �Y ��X�W	�V�Y 0 ntf_full  �X �U
�U 
  �T�S�R�T 0 ntf_custom_title  �S 0 ntf_custom_subtitle  �R 0 ntf_text  �W   �Q�P�O�Q 0 ntf_custom_title  �P 0 ntf_custom_subtitle  �O 0 ntf_text  	 �N�M�L�K
�N 
appr
�M 
subt�L 
�K .sysonotfnull��� ��� TEXT�V 
����  �J ��I�H�G�J 0 ntf_message  �I �F�F   �E�E 0 ntf_text  �H   �D�D 0 ntf_text   �C�B�A�@
�C 
appr
�B 
subt�A 
�@ .sysonotfnull��� ��� TEXT�G ��b   �b  �  �?�?      ��>�=�<
�> 
brow�=]�
�< kfrmID     ��;�:�9
�; 
brow�:]�
�9 kfrmID    �8  ��7
�7 
pfrp
�8 
cwin   ��6�5�4
�6 
brow�5]�
�4 kfrmID     ��3�2�1
�3 
brow�2Z�
�1 kfrmID  �w �v  � ` S u c c e s s f u l l y   c l o s e d   5   b a c k g r o u n d   F i n d e r   w i n d o w s . ascr  ��ޭ