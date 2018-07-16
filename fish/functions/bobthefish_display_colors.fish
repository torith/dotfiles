function bobthefish_display_colors -a color_scheme -d 'Print example prompt color schemes'

  set -l color_schemes default light \
    solarized solarized-light \
    base16 base16-light \
    gruvbox zenburn \
    dracula \
    terminal terminal-dark-white \
    terminal-light terminal-light-black \
    terminal2 terminal2-dark-white \
    terminal2-light terminal2-light-black

  switch "$color_scheme"
    case '--all'
      for scheme in $color_schemes
        echo
        echo "$scheme:"
        bobthefish_display_colors $scheme
      end
      return

    case $color_schemes
      __bobthefish_colors $color_scheme

    case ''
      __bobthefish_colors $theme_color_scheme
      type -q bobthefish_colors
        and bobthefish_colors

    case '*'
      echo 'usage: bobthefish_display_colors [--all] [color_scheme]'
      return
  end

  __bobthefish_glyphs

  echo
  set_color normal

  __bobthefish_start_segment $color_initial_segment_exit
  echo -n exit '! '
  set_color -b $color_initial_segment_su
  echo -n su '$ '
  set_color -b $color_initial_segment_jobs
  echo -n jobs '% '
  __bobthefish_finish_segments
  set_color normal
  echo -n "(<- initial_segment)"
  echo

  __bobthefish_start_segment $color_path
  echo -n /color/path/
  set_color -b $color_path_basename
  echo -ns basename ' '
  __bobthefish_finish_segments
  echo

  __bobthefish_start_segment $color_path_nowrite
  echo -n /color/path/nowrite/
  set_color -b $color_path_nowrite_basename
  echo -ns basename ' '
  __bobthefish_finish_segments
  echo

  __bobthefish_start_segment $color_path
  echo -n /color/path/
  set_color -b $color_path_basename
  echo -ns basename ' '
  __bobthefish_start_segment $color_repo
  echo -n "$branch_glyph repo $git_stashed_glyph "
  __bobthefish_finish_segments
  echo

  __bobthefish_start_segment $color_path
  echo -n /color/path/
  set_color -b $color_path_basename
  echo -ns basename ' '
  __bobthefish_start_segment $color_repo_dirty
  echo -n "$tag_glyph repo_dirty $git_dirty_glyph "
  __bobthefish_finish_segments
  echo

  __bobthefish_start_segment $color_path
  echo -n /color/path/
  set_color -b $color_path_basename
  echo -ns basename ' '
  __bobthefish_start_segment $color_repo_staged
  echo -n "$detached_glyph repo_staged $git_staged_glyph "
  __bobthefish_finish_segments
  echo

  __bobthefish_start_segment $color_vi_mode_default
  echo -ns vi_mode_default ' '
  __bobthefish_finish_segments
  __bobthefish_start_segment $color_vi_mode_insert
  echo -ns vi_mode_insert ' '
  __bobthefish_finish_segments
  __bobthefish_start_segment $color_vi_mode_visual
  echo -ns vi_mode_visual ' '
  __bobthefish_finish_segments
  echo

  __bobthefish_start_segment $color_vagrant
  echo -ns $vagrant_running_glyph ' ' vagrant ' '
  __bobthefish_finish_segments
  echo

  __bobthefish_start_segment $color_username
  echo -n username
  set_color normal
  set_color -b $color_hostname[1] $color_hostname[2..-1]
  echo -ns @hostname ' '
  __bobthefish_finish_segments
  echo

  __bobthefish_start_segment $color_rvm
  echo -ns $ruby_glyph rvm ' '
  __bobthefish_finish_segments

  __bobthefish_start_segment $color_virtualfish
  echo -ns $virtualenv_glyph virtualfish ' '
  __bobthefish_finish_segments

  __bobthefish_start_segment $color_virtualgo
  echo -ns $go_glyph virtualgo ' '
  __bobthefish_finish_segments

  __bobthefish_start_segment $color_desk
  echo -ns $desk_glyph desk ' '
  __bobthefish_finish_segments

  echo -e "\n"
end