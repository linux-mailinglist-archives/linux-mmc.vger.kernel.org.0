Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A791F6D4FB3
	for <lists+linux-mmc@lfdr.de>; Mon,  3 Apr 2023 19:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjDCR47 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 3 Apr 2023 13:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjDCR4z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Apr 2023 13:56:55 -0400
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Apr 2023 10:56:39 PDT
Received: from arashi.greysector.net (arashi.greysector.net [51.68.141.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7746610CA
        for <linux-mmc@vger.kernel.org>; Mon,  3 Apr 2023 10:56:39 -0700 (PDT)
Received: from sakura.greysector.net (unknown [212.180.189.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by arashi.greysector.net (Postfix) with ESMTPSA id 8AD43981
        for <linux-mmc@vger.kernel.org>; Mon,  3 Apr 2023 19:51:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 arashi.greysector.net 8AD43981
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greysector.net;
        s=default; t=1680544288;
        bh=p8qEDwQ4hknjJPlBetlApfsDPdLN7P79cbMN94i+olU=;
        h=Date:From:To:Subject:From;
        b=ATxIC6iUPw2b6vjAV138fPux3+eW1UYSRD+/r6OV+jHvCBjQRzU55dfHcQZLOS33R
         /yYSbzpntPwIdQ+32z2RwpQg8ZyuLG3NiStrewXG0jQVHmUhkpjxA3nWGGPAmuN31c
         6Yb/mOQmBFMnGMY8XlL1y4iKV0ZMZd8NHhsUzdbg=
Date:   Mon, 3 Apr 2023 19:51:27 +0200
From:   Dominik 'Rathann' Mierzejewski <dominik@greysector.net>
To:     linux-mmc@vger.kernel.org
Subject: mmc-utils: ioctl connection timed out with SD cards
Message-ID: <ZCsSHxDv+158emk5@sakura.greysector.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,
is the mmc tool from mmc-utils supposed to work with SD cards?
I tried mmc status get /dev/mmcblkN with three different SD cards
on two different machines (Pinebook Pro and a Sony laptop) and I get
the same error on both:
# mmc status get /dev/mmcblk0
ioctl: Connection timed out
Could not read response to SEND_STATUS from /dev/mmcblk0

dmesg on the Sony machine shows:
[ 1291.196547] mmc0: new SD card at address aaaa
[ 1291.196834] mmcblk0: mmc0:aaaa SD01G 969 MiB 
[ 1291.200263]  mmcblk0: p1 p2 p3
[ 1306.273160] rtsx_pci_sdmmc rtsx_pci_sdmmc.0: __mmc_blk_ioctl_cmd: cmd error -110
[ 1306.276978]  mmcblk0: p1 p2 p3

I'm able to get status of the internal eMMC device on Pinebook Pro
with no errors. extcsd read works fine, too.

I'm running Fedora 38 with kernel 6.2.9 on both machines if that helps.

Regards,
Dominik
-- 
Fedora   https://getfedora.org  |  RPM Fusion  http://rpmfusion.org
There should be a science of discontent. People need hard times and
oppression to develop psychic muscles.
        -- from "Collected Sayings of Muad'Dib" by the Princess Irulan
