Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB9CA19534A
	for <lists+linux-mmc@lfdr.de>; Fri, 27 Mar 2020 09:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgC0Ivl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 27 Mar 2020 04:51:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:2969 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725946AbgC0Ivk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Mar 2020 04:51:40 -0400
X-UUID: 05956734b9f940af800a65cf1daed05a-20200327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QTjXbM/ov07PfVZIe9dgG0GC3IDbO7iekkr5VscE9FI=;
        b=k5VeB1j/5ZqqW8d5/i8xncz/SZv4CO4Q9AZ83Sn/vGKd9qwR9Np7Cgmio9MQ6SRqhbA4GRW0n20cALfT0fLo6dsEtNNyHskZRRnHBYPOkqhuVkUkEeMqCj+xSv2DyLkzNlhqJDrIBRKQmJFDLFFEn7iuI3htH46DKj+L17J9mSQ=;
X-UUID: 05956734b9f940af800a65cf1daed05a-20200327
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.mao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1903909439; Fri, 27 Mar 2020 16:51:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 27 Mar 2020 16:51:34 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 27 Mar 2020 16:51:32 +0800
From:   Yong Mao <yong.mao@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v2] mmc: mediatek: fix SDIO irq issue
Date:   Fri, 27 Mar 2020 16:51:36 +0800
Message-ID: <1585299097-6897-1-git-send-email-yong.mao@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

eW9uZyBtYW8gKDEpOg0KICBtbWM6IG1lZGlhdGVrOiBmaXggU0RJTyBpcnEgaXNzdWUNCg0KIGRy
aXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgfCA0MSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspDQoNCi0tIA0K
MS45LjENCg==

