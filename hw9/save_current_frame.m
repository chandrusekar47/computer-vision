function [] = save_current_frame (outputFileName)
% saves whatever is displayed in the window to the given file. useful when
% there is dynamic text rendered on top of the image and that should also
% be saved to the file
   fig = gcf;
   frame = getframe(fig);
   imwrite(frame.cdata, outputFileName);
end