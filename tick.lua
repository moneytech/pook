function PushVert( x, y, z, cx, cy, cz, nx, ny, nz )
	cx = cx or 1; cy = cy or 1; cz = cz or 1
	nx = nx or 0; ny = ny or 1; nz = nz or 0
	PushVert_internal( x, y, z, cx, cy, cz, nx, ny, nz )
end

function MakeMeshes( )
	PushVert( 0, 1, 0, 0.1, 0.4, 0.8 )
	PushVert( -1, -1, 0, 0.1, 0.4, 0.8 )
	PushVert( 1, -1, 0, 0.1, 0.4, 0.8 )
	PushMesh( "triangle" )
	print( "pushing triangle mesh" )
end

s = math.sin
c = math.cos

function Tick( dt )
	print( "called Tick" )
	print( "dt was", dt )
	
	if not init then
		init = true
	end
	
	for i = 0, 3 do
		PushInstance( "triangle", 0, i * c( dt ), i * s( dt ) )
	end
	Flush( "simple" )
end
