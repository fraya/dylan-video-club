Module: video-club-app

define function main
    (name :: <string>, arguments :: <vector>)
  exit-application(0);
end function;

main(application-name(), application-arguments());
