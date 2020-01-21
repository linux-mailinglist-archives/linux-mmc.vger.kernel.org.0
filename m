Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2141436EC
	for <lists+linux-mmc@lfdr.de>; Tue, 21 Jan 2020 07:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgAUGDt (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 21 Jan 2020 01:03:49 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:30938 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgAUGDt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2020 01:03:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579586629; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Date: Message-ID: From: To: Sender;
 bh=2fwXRU2Yt5QWJJo8DPtfPPXb4CAZxjYjNNDV1hnSKfc=; b=BKREsNvjoEmbqBvQkBL9OwTfaM7Q4kifWUc00vb2Vxc0faf1CeoILTeKaciIELrzj6uZhp7L
 8OKsAgDgSVPTAwlhuxwCwDm3FbSrFzccALEiX3sM22RDmjwGld5/Q54D8DBZeibZLaE1bbjw
 /U4lM1XXR5FlYXZ7VK0e5FCb2JQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e269443.7f0e5f1d90d8-smtp-out-n01;
 Tue, 21 Jan 2020 06:03:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 130C3C43383; Tue, 21 Jan 2020 06:03:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=2.0 tests=ALL_TRUSTED,MISSING_SUBJECT,
        SPF_NONE,TVD_SPACE_RATIO autolearn=no autolearn_force=no version=3.4.0
Received: from [10.242.51.238] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sbhanu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63AF5C433CB
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jan 2020 06:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63AF5C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sbhanu@codeaurora.org
To:     linux-mmc@vger.kernel.org
From:   Sajida Bhanu <sbhanu@codeaurora.org>
Message-ID: <506e1df3-c164-5867-629f-aecb9780aa99@codeaurora.org>
Date:   Tue, 21 Jan 2020 11:33:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

subscribe linux-mmc
