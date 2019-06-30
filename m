Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED1B5AFA8
	for <lists+linux-mmc@lfdr.de>; Sun, 30 Jun 2019 12:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfF3KkB (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 30 Jun 2019 06:40:01 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:55370 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF3KkB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 30 Jun 2019 06:40:01 -0400
Received: by mail-io1-f69.google.com with SMTP id f22so11990388ioh.22
        for <linux-mmc@vger.kernel.org>; Sun, 30 Jun 2019 03:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eziCMEFtU+C3qoNYfJHsPKHY2FKR9JngSHlmZZHqzFo=;
        b=awnNJNi+CjpeyNLwLaepWDdAGcMCh+VPCDKSqeOA0b98YMR3TinQBtQ39OFtYtf8Zo
         8Uh2ea/eWD68YOSbxBv3qw9UotniUgEqD3ZkBqMML2UFim3PXF8SxrO6mEymj53kJNW0
         NNpg0R2HwaB5BlYweBKBZLt04u8y7qr1rCCwmkwP3R2wCIz5DvMxDQdUJSu2Gg5AD07q
         Rgm4N7JISfwLITFKhN5qU+QFHxqfGb5xVoCqrR7R3lrrmOGzv0kifjqSszO+81QCePVA
         kRAk9ylJARQju91no7LA9aB1kNxF5RQ39+dJlOQPCScmnIza3PQT658VmYIu0tKPQBuk
         rXFQ==
X-Gm-Message-State: APjAAAWpNaB/QCkz1yME441t9IDn5NTK08r/oHMwK1i4L6xwK1dWy7FO
        mMG4Ysd2gVT2HmCBj/XkPdopjK9mVVMo5IE7vL0MjNPmLObz
X-Google-Smtp-Source: APXvYqwc7jNxeDwuXuaVmtRV4iFyubee59JJU/yaTue7FDuw9a59U5XBHdkSI5CIzX3MUpYnDTjMD5X25A8OGVnPI50yMEKLHG28
MIME-Version: 1.0
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr10128962jan.90.1561891200769;
 Sun, 30 Jun 2019 03:40:00 -0700 (PDT)
Date:   Sun, 30 Jun 2019 03:40:00 -0700
In-Reply-To: <0000000000003ec128058c7624ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003326c1058c8822c7@google.com>
Subject: Re: WARNING in kernfs_create_dir_ns
From:   syzbot <syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        hongjiefang@asrmicro.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

syzbot has bisected this bug to:

commit 7f38abf220e2c800a2c451372e9f07ed5fd0ea49
Author: Hongjie Fang <hongjiefang@asrmicro.com>
Date:   Tue Jul 31 02:55:09 2018 +0000

     mmc: core: improve reasonableness of bus width setting for HS400es

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129d6755a00000
start commit:   72825454 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=119d6755a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=169d6755a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31528e58cc12e2
dashboard link: https://syzkaller.appspot.com/bug?extid=38f5d5cf7ae88c46b11a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6c439a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1353c323a00000

Reported-by: syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com
Fixes: 7f38abf220e2 ("mmc: core: improve reasonableness of bus width  
setting for HS400es")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
