#! /usr/bin/octave -qf

function complexhologram

%%%%%%%%%%%%%
% CONSTANTS %
%%%%%%%%%%%%%

dpi = 600.0;
wavelength = 630e-9; % in meters!
sampling = 0.0254/dpi; % scale this to whatever dpi we have -> this assumes 600 dpi

%%%%%%%%%%%%%%%%%%%%%%
% Init Hologram Film %
%%%%%%%%%%%%%%%%%%%%%%

dimensions = 1; 
range = dimensions * 0.0254/2.0;
ipx = (-1*range):sampling:range;
ipy = (-1*range):sampling:range; 

film = zeros(size(ipx,2), size(ipy,2));


%%%%%%%%%%%%%%%%%%%%%%%%
% Define Object Points %
%%%%%%%%%%%%%%%%%%%%%%%%

objectpoints = [0 0 4];   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Begin Hologram Computation %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for o=1:size(objectpoints,1)
	for i=1:size(ipx, 2)
		for j=1:size(ipy,2)
					
			dx = objectpoints(o,1) - ipx(i);
			dy = objectpoints(o,2) - ipy(j);
			dz = objectpoints(o,3) - 0;

			distance = sqrt(dx^2 + dy^2 + dz^2);
			complexwave = exp(2*pi*sqrt(-1)*distance/(wavelength));
			film(i,j) =  film(i,j) + complex(real(complexwave), imag(complexwave));
          		fprintf('%f + %fi \n', real(film(i,j)), imag(film(i,j)));																			
		end
	end	
end

imwrite(real(film), 'images/out.png');

endfunction


complexhologram()
