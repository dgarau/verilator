#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2008 by Wilson Snyder. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.

$Self->{vlt} or $Self->skip("Verilator only test");

compile(
    verilator_flags2 => ["--lint-only -Wall -Wno-DECLFILENAME"],
    fails => 1,
    verilator_make_gcc => 0,
    make_top_shell => 0,
    make_main => 0,
    expect =>
'%Warning-UNDRIVEN: t/t_lint_unused_iface_bad.v:\d+: Signal is not driven: sig_udrv
%Warning-UNDRIVEN: Use .*
%Warning-UNUSED: t/t_lint_unused_iface_bad.v:\d+: Signal is not used: sig_uusd
%Error: Exiting due to .*',
    );

ok(1);
1;

