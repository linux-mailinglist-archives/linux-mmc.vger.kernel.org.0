Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3B7A2296
	for <lists+linux-mmc@lfdr.de>; Thu, 29 Aug 2019 19:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfH2RmF (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 29 Aug 2019 13:42:05 -0400
Received: from mxout1.thunder2.prohost.de ([91.233.87.120]:48651 "EHLO
        mxout1.thunder2.prohost.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbfH2RmE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Aug 2019 13:42:04 -0400
Received: from thunder2.prohost.de (localhost [127.0.0.1])
        by mxout1.thunder2.prohost.de (8.14.7/8.13.8) with ESMTP id x7THNW31097730
        for <linux-mmc@vger.kernel.org>; Thu, 29 Aug 2019 19:23:32 +0200
Received: (from mpynet@localhost)
        by thunder2.prohost.de (8.14.7/8.13.8/Submit) id x7THNWMj097729;
        Thu, 29 Aug 2019 19:23:32 +0200
Date:   Thu, 29 Aug 2019 19:23:32 +0200
Message-Id: <201908291723.x7THNWMj097729@thunder2.prohost.de>
To:     "Linux MMC Development" <linux-mmc@vger.kernel.org>
From:   "Manuel Presnitz" <mail@mpy.de>
Reply-to: "Manuel Presnitz" <mail@mpy.de>
In-reply-to: <20190827081043.15443-1-ulf.hansson@linaro.org>
X-Mailer: Perl powered Socket Mailer via www.mpy.de
Subject: Re: [PATCH] mmc: core: Fix init of SD cards reporting an invalid VDD range
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Thanks for your efforts and the patch!

I tested it on my "Fujitsu Celsius H760" notebook running kernel version 5.2.7 (Arch). It has a "Realtek Semiconductor Co., Ltd. RTS524A PCI Express Card Reader" using the "rtsx_pci" module.

Without the patch my "SanDisk Extreme SD-XC UHS-I" card (128GB) had thrown the error "mmc0: error -110 whilst initialising SD card", but with the patch the very same card is recognized and is working flawlessly!

Regards,
Manuel.

