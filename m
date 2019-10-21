Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64E9ADE62C
	for <lists+linux-mmc@lfdr.de>; Mon, 21 Oct 2019 10:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfJUIV1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 21 Oct 2019 04:21:27 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:39589 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfJUIV1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Oct 2019 04:21:27 -0400
Received: by mail-pg1-f169.google.com with SMTP id p12so7317956pgn.6
        for <linux-mmc@vger.kernel.org>; Mon, 21 Oct 2019 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6+GMw022+X3JYw6WrtEO7OwQt3rIr3LBpdSfg6RGujk=;
        b=aEBwsuf8cqM7W/1mTUqYu+k95iPSREnXCp2DsUDWvLgjjsOGfdpDY+Qu+EbdpZIIcL
         hJqD+X5v9C+rzYKq9+631CtDykZRtMG0mDgB7N31epiiGVZIObs1X7zL9qEzwLuTTeAp
         YgJgaELAER5bSy2aBi0tk/WI3UwIBoT9G6eF0OYp9/L9a3yDEFbo0kAON73wt86MW/8g
         4mNv0Sy6vPcpCDut8nRJR3TVpHCu8WZ4LVs4uCMh9PI9u5UeJR7YoMTsetm6yCwiwrI/
         tSr+wGr11lQhgtO0ESswr1hjWMn22OBKd6gx73O5WD+83s+ghqOjgeoUPU4tEqI5xPRV
         nUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6+GMw022+X3JYw6WrtEO7OwQt3rIr3LBpdSfg6RGujk=;
        b=A0j8Idv3jjZF65O4l8xffuv8X5Ut4RkLEw2/5CUxIdtLp19KmdgSITTD5TdFE0bMG6
         yySMHsKXkUQEpLzmbovFF9PwqQo7xWaGJuNzkmEHbpUtS9mGR0d66zF9NFIN3jGAvt58
         nQNamWJnj78MUlrMrNBnqLdwePJnPe9zw/++ENPOP/a5ovd0e+pnJrrrgSj7RsD8hEBC
         k3cRwV1r8jU0EJyG8CC5RDc8ttLaXk7UKBAFaKOYHOt7Id0MAq9+ZA8eBR8yBUebPPCk
         L8gY2PNiHlYMLCLlRUXiMupUSNwdsJUBezHsBSzD3OPgBXWElz3Qh5NkBjk0cBWf127V
         Ou2g==
X-Gm-Message-State: APjAAAUI06+dWef9hedHc16hFzyxYmxrjyE0Bwv+KuJgucW5FQzTAWx3
        NgwpNA9ibl8y9DDAuFE5XxKvdDX/I81jxdyeCkekesh4DcI=
X-Google-Smtp-Source: APXvYqw8iFCTR08SStKgWjKDC+uuiG9db+ZpEJJJj1j2mnh21E1+OV9FZN4vf+EsoOwYnqzuQw66d/wb1e1VnLCTDTY=
X-Received: by 2002:aa7:8ad0:: with SMTP id b16mr22068797pfd.255.1571646086174;
 Mon, 21 Oct 2019 01:21:26 -0700 (PDT)
MIME-Version: 1.0
From:   Yi Zheng <goodmenzy@gmail.com>
Date:   Mon, 21 Oct 2019 16:19:32 +0800
Message-ID: <CAJPHfYNiibuOnQb_oJPVfB7rDiOqO1widt8wkTU4oQ1fJ6NwMQ@mail.gmail.com>
Subject: MMC life-time register, why not updated very time when reading the
 attribute in /sys
To:     linux-mmc@vger.kernel.org, Jungseung Lee <js07.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi, all,

  In the commit v4.10-rc8-9-g46bc5c408e4e, Jungseung Lee introduced an easy
way to access the EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A/B registers.

  That is fine, it avoid to parse the ECSD raw data from the debugfs mnt point:
 /sys/kernel/debug/mmc0/mmc0:0001/ext_csd.

But the code seems that only read the ECSD when init the Card. On our machines
with BGA chip, run in long time, that sysfs attr seems not updated. It
only keeps the
original values when booting/init.

Any plan to update that ?
