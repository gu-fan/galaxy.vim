##INTRO##
**galaxy** is a vim colorscheme that generate schemes with colors.
    
* With this you can:

        Get your preferred colorscheme in a simplest way.
            1.Input your scheme name
            2.Choose your preferred color for background.
        You got it.

* With this you get:

        5 built-in schemes.
        1-color-to-scheme generator.
        5-color to tune your schemes.
        100+ schemes generate simply with colorname-list.
        A window to choose schemes easily.

        And...
        Terminal (256/16/8) support with all schemes.
        Insert-mode statusline hightlight.
        Tab/Fold/Popmenu/Wild Menu/... with comfort balance.
        Synatax colors with distinct contrast.
        Diff colors clearly shows the diff texts.
        ...

**Take a glance:** 

    Built-in Themes:

* in GUI          ![http://i55.tinypic.com/u0qh2.png](http://i55.tinypic.com/u0qh2.png)

* in TERM(256)    http://i56.tinypic.com/2nr234y.png

* Galaxy window   http://i56.tinypic.com/153rzgp.png
   

**where to start:**

        :colorscheme galaxy
        :Galaxy

**NOTE**: require vim plugin:ColorV

**NOTE**: If you have built a nice scheme and want to share it.

          Post it at https://github.com/Rykka/vim-galaxy/issues 
##Use:##
Load galaxy~

        :colorscheme galaxy

Open galaxy manager window~

        <leader>gll or :Galaxy

        Then you can choose/edit/generate/delete schemes in it.

Generate new schemes~

        'gn'
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
