##INTRO##
**galaxy** is a vim colorscheme that generate schemes with colors.
    
* With this you can:

        Get your preferred colorscheme in a simplest way.
        
        Press `<leader>glg` or input `:GalaxyGen`,then:
            1.Input your scheme name
            2.Choose your preferred color for background.
        You got a scheme!
        And the manager is opened for further tuning.

* With this you got:

        5 built-in schemes.
        100+ schemes generated simply with colorname-list.
        Terminal (256/16/8) support for all schemes.

**Take a glance:** 

* Built-in schemes:

    - in GUI          ![http://i55.tinypic.com/u0qh2.png](http://i55.tinypic.com/u0qh2.png)

    - in TERM(256)    http://i56.tinypic.com/2nr234y.png

* Highligs:
  
    - A built-in:     http://imgur.com/s2Osg.png
            
    - A generated:    http://i.imgur.com/OpqR2.png
      
**where to start:**

        :colorscheme galaxy
        :Galaxy

**NOTE**: Require vim plugin:ColorV
            
          http://www.vim.org/scripts/script.php?script_id=3597 

**NOTE**: If you have built a nice scheme and want to share it.

          Post it at https://github.com/Rykka/vim-galaxy/issues 
##Use:##
Load galaxy~

        :colorscheme galaxy
        To use it persistently. Put it in your vimrc.

Open galaxy manager window~

        <leader>gll or :Galaxy

        Then you can choose/edit/generate/delete schemes in it.

Generate new schemes~

        <leader>glg or :GalaxyGen
        Input your scheme's name.
        Then choose a color as the schemes background. then press 'q'
        To quit the choosing window. The schemes auto generated.
        And you will got your scheme loaded immediately.

Edit your schemes~

        Move cursor on the color you want to edit. 
        Then press 'e'
        Then choose your desired color for it.
        Press 'q' to quit the window. 
        And you will got the changed scheme loaded immediately.

Generate schemes with colorlist~

        Open ColorV built-in colorname list.
        <leader>cl or :ColorVlist
        You will got a colorlist window opened with W3C standard colorname.
        Put cursor in it. Then press '<leader>gla'
        All the colorlist in it will be generated to schemes.
        Now you got 100+ schemes.
        Colorlist like 'COLORNAME #ffffff' will be processed.

Delete schemes~

        move cursor in the galaxy window. 
        press 'dd'.
        The scheme will be deleted.
    
With Terminal~

        If it does not work correctly.
        You should check your '&t_Co' option.
        And set 'g:galaxy_term_color' to the number it support.


>   **NOTE**    

            Your previous scheme is cached on your disk.
            And gui scheme is seperated with terminal.
            So you can set them with different scheme.

>   **NOTE**        

            Terminal scheme in 8/16 terminal color is predefined.

>   **NOTE**       

            Terminal cursor may have bugs. 
            And only support "xterm\rxvt\screen\TMUX" now.
            If Term color not work properly.
            Please report your [OS,vim version,&t_Co,&term]
            at https://github.com/Rykka/vim-galaxy/issues 


##Install:##
1.Using [Vundle.vim](https://github.com/gmarik/vundle) (Recommend):~



After installed vundle and git. Add this line to your vimrc  

        `Bundle 'Rykka/vim-galaxy'` 
        `Bundle 'Rykka/ColorV'` 

Run `:BundleInstall` to install.

And update them easily by `:BundleInstall!`
 
2.Using [Galaxy on Vim.org](http://www.vim.org/scripts/script.php?script_id=3597)~
 
You should download latest [ColorV on Vim.org](http://www.vim.org/scripts/script.php?script_id=3597) first.


Download the latest version of [Galaxy on Vim.org](http://www.vim.org/scripts/script.php?script_id=3729)  

Extract to $VIMFILE folder. 

("~/.vim" for linux. "$HOME/vimfiles" for windows)

Generate helptags. `:helptags ~/.vim/doc
 

>   **NOTE**       

           Remember to install vim plugin 'ColorV' as forementioned.

>   **NOTE**       

           You can always get the latest version at
           https://github.com/Rykka/vim-galaxy/
           And you can report bugs and suggestions at
           https://github.com/Rykka/vim-galaxy/issues 
