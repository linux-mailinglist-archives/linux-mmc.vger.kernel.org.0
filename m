Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EAD2C946F
	for <lists+linux-mmc@lfdr.de>; Tue,  1 Dec 2020 02:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgLABJY (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 30 Nov 2020 20:09:24 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:45788 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgLABJY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2020 20:09:24 -0500
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Nov 2020 20:09:23 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 3A033200E20A;
        Tue,  1 Dec 2020 09:02:49 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dr0PCsS0E-J9; Tue,  1 Dec 2020 09:02:49 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 19A88200E233;
        Tue,  1 Dec 2020 09:02:49 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.188.227])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id E2FF1C019E2;
        Tue,  1 Dec 2020 09:02:48 +0800 (HKT)
To:     linux-rockchip@lists.infradead.org
Cc:     linux-mmc@vger.kernel.org
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Subject: rk3399: mmc: hs400 strobe clock > 200Mhz
Message-ID: <c6467d6a-cf67-fde8-801d-c9ec3aa55a93@gtsys.com.hk>
Date:   Tue, 1 Dec 2020 09:02:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi

I reach out with a problem we identify with SanDisk 8G eMMC
85% of our production works well with hs400es and hs400 configuration,
the other 15% have problems detecting the chip.
For the failure analysis for the unstable boards have the strobe
clock of more then 200Mhz. We measured 204.7Mhz, looks like a
chip related problem.

Anything we can improve on the rockchip / mmc stack?

-Chris
