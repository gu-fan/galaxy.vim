##INTRO##
    **galaxy** is a colorscheme with infinite schemes.
    With this you got:
        5 built-in schemes.
        Generate schemes by 1 color.
        Edit schemes by 5 color.
        Generate 100++ schemes with color-list.
        Terminal (8/16/256) support with all schemes.
        StatusLine highlight with insert-enter.
        ...

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
        Colorlist like 'COLORNAME #ffffff' will be processed.

    Delete schemes~
        move cursor in the galaxy window. 
        press 'dd'.
        The scheme will be deleted.
    
    With Terminal~
        If it does not work correctly.
        You should check your '&t_Co' option.
        And set 'g:galaxy_term_color' to the number it support.


##Install:##
1.Using [Vundle.vim](Recommend):~
    https://github.com/gmarik/vundle
    After install. Add this line to your vimrc  `Bundle 'Rykka/vim-galaxy'` 
    Run `:BundleInstall` to install.
    And update ColorV easily by `:BundleInstall!`
 
2.Using [Galaxy on Vim.org]~
 
    Download the latest version of tar.gz file, 
    Extract to $VIMFILE folder. 
    ("~/.vim" for linux. "$HOME/vimfiles" for windows)
    Generate helptags. `:helptags ~/.vim/doc
 
     NOTE   If you got any bugs or suggestions.
            Please post it at https://github.com/Rykka/vim-galaxy . 
        
