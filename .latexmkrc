add_cus_dep('glo', 'gls', 0, 'makeglo2gls');
sub makeglo2gls {
    my ($base_name, $path) = fileparse( $_[0] );
    pushd $path;
    #my $return = system("makeindex -s '$_[0]'.ist -t '$_[0]'.glg -o '$_[0]'.gls '$_[0]'.glo");
    my $return = system("makeglossaries $base_name");
    popd;
    return $return;
}
