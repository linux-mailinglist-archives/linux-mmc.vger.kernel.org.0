Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0125AB5B4
	for <lists+linux-mmc@lfdr.de>; Fri,  6 Sep 2019 12:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbfIFKVl (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 6 Sep 2019 06:21:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39394 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388384AbfIFKVl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Sep 2019 06:21:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id j16so5509941ljg.6
        for <linux-mmc@vger.kernel.org>; Fri, 06 Sep 2019 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1XE2iMKxqeBeswKR1xzlvsta7f6sdclLOJUEbI6gihw=;
        b=YgHnUrQFNAnUFKkSbc+ykNP3SwrMbo4pz/pL3+7+Qx9w+CAWd+tNrsn2u0v+YLkekQ
         dCwgypVInxxZ5mQfogIfnoLu+yPJ1WI3NVcVIm8FBMQjHrmC37Fh6i7jV4g32cjj5mL9
         b12VsfeTm1Hz70kyn6v+HJyIRkOjafMVsu2S0DoguhuHantMkAfnktdV8qrXwIuha5z+
         zdj72rwfsCx2X/Iq4keEi4fIV1V5tQlHGQhJvS9zmzHvTfHyEOKcUBqxD0Uj99WtrNHV
         IqS+HISWroSfN/+i+orD93kB3ndJXJdpI5IpLje5PFWW1GqT3KtyuJuZytxLWxfoPapy
         g+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1XE2iMKxqeBeswKR1xzlvsta7f6sdclLOJUEbI6gihw=;
        b=ZNkNsl+RDX8Y2bCNcQ9HwnOFuPeeT7ILC+XtebgFsOd6FCg0RDzjuV5yq026TcG2TX
         jHznsYjUMyHQ2PyRB24d8pn1eqOQw4O+7f6ZcnXsP75LpgmGujuhwM0bduBmw1FG3/bH
         nxnnzVwfLBcEhb/AVmFOuL3xOTXX/CMO9vcwO7nl99WnYFyP9uAorKKNTHsTf99c4DlS
         NZOo4NML46Ew1YbEp6e7X0KJXXk9m+cEtRBtNMBMUBq3M/tNn6WP6NyfFdg2xdrO+IYW
         5iit/X1+F2rLwXQiAtBSzmoApua1/RsxhHuTzUays5KolEzcj+iOZnc0IouDSX/foCLR
         kLKA==
X-Gm-Message-State: APjAAAVN3FrXYQcO5MvdL75xMk7rawGv1ZIOoFseRI3vrWnu3GaqO6V/
        Yy8j9AelIbw3rYtorf/CgBK+kQ==
X-Google-Smtp-Source: APXvYqztTS4qpegFJb8eFFnKk7dV5idrDYMnWk/xNLDWvDE9Uz5saL21N7D+aNgevoeKewjXLExpzg==
X-Received: by 2002:a2e:50b:: with SMTP id 11mr5314059ljf.11.1567765299406;
        Fri, 06 Sep 2019 03:21:39 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id s7sm855763lji.26.2019.09.06.03.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 03:21:38 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.3-rc8
Date:   Fri,  6 Sep 2019 12:21:37 +0200
Message-Id: <20190906102137.637-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with an MMC fix intended for v5.3-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc7

for you to fetch changes up to 8ad8e02c2fa70cfddc1ded53ba9001c9d444075d:

  Revert "mmc: core: do not retry CMD6 in __mmc_switch()" (2019-09-03 16:53:28 +0200)

----------------------------------------------------------------
MMC core:
 - Fix card init for some eMMCs that need retries for CMD6

----------------------------------------------------------------
Jan Kaisrlik (1):
      Revert "mmc: core: do not retry CMD6 in __mmc_switch()"

 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
