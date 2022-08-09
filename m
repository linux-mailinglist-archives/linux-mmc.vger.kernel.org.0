Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B0358DE11
	for <lists+linux-mmc@lfdr.de>; Tue,  9 Aug 2022 20:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345142AbiHISKG (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 9 Aug 2022 14:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345150AbiHISJc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Aug 2022 14:09:32 -0400
Received: from blackstone.apzort.in (unknown [202.142.85.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAC829C8C
        for <linux-mmc@vger.kernel.org>; Tue,  9 Aug 2022 11:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=anurav.com;
        s=default; h=Content-Type:MIME-Version:Message-ID:Reply-To:From:Date:Subject:
        To:Sender:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YC2OZCaRVHccupr4C95OTr/KZ67+Q/i8utOxeo+u1sU=; b=WGZQbg3OTr3ZkTujlRaH0iLdn6
        YBjFzhWYK6RN7RK7LrcXkvQxcQbR2anKNDhI5q3Uu8oZf7rhFwbK6uj5cp/rO/S1sKM4N3hSYEdit
        2nPbXdDpNN0HDLth9z4NzjaupcG8hSnuA+oDO06cD3bMWsDRzqFgl/anGgsS0Jn2M/ioKCJ9UJ+PN
        yPTYSDI3zEu4xAyMfcLZAuCqwqEgHnLvCDzi4GmcUiWdlYilX20l53Zx71D0rWSXgvqfEHpZXwBbq
        /+bJcc8APR/mzie2DDtr8NT5U2JSjX6nKttkuqEbbiZsQqwtmP9qu8uPA5ZqQgpzikESyhi4y2njz
        JZhYw9Uw==;
Received: from apzort by blackstone.apzort.in with local (Exim 4.94.2)
        (envelope-from <apzort@blackstone.apzort.in>)
        id 1oLNXf-00FGg6-UZ
        for linux-mmc@vger.kernel.org; Tue, 09 Aug 2022 17:07:00 +0530
To:     linux-mmc@vger.kernel.org
Subject: =?us-ascii?Q?Anurav_Dhwaj__"Kryptowahrung_macht_Sie_zum_Mill?=  =?us-ascii?Q?ionar"?=
X-PHP-Script: www.anurav.com/index.php for 191.101.31.24
X-PHP-Originating-Script: 1000:PHPMailer.php
Date:   Tue, 9 Aug 2022 11:36:59 +0000
From:   Anurav Dhwaj <mail@anurav.com>
Reply-To: mail@anurav.com
Message-ID: <4ZmyHDQRENWeL53QjDsZKJYGY8L4Cf1X106vu1p4nU@www.anurav.com>
X-Mailer: PHPMailer 6.6.0 (https://github.com/PHPMailer/PHPMailer)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - blackstone.apzort.in
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [1000 989] / [47 12]
X-AntiAbuse: Sender Address Domain - blackstone.apzort.in
X-Get-Message-Sender-Via: blackstone.apzort.in: authenticated_id: apzort/from_h
X-Authenticated-Sender: blackstone.apzort.in: mail@anurav.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,PHP_SCRIPT,
        RCVD_IN_PBL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [202.142.85.54 listed in zen.spamhaus.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.8 RDNS_NONE Delivered to internal network by a host with no rDNS
        *  2.3 PHP_SCRIPT Sent by PHP script
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Message Body:
Investieren Sie noch heute und werden Sie der nachste Milliardar... https://telegra.ph/Deutschland-hat-eine-neue-Einnahmequelle-von-633697-Euro-pro-Woche-08-07-2

-- 
This e-mail was sent from a contact form on Anurav Dhwaj  (https://www.anurav.com)

